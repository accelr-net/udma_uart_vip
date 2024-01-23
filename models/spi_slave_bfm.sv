`timescale 1ns/1ns
module spi_slave_bfm(sclk, mosi, miso, ss);
   input logic sclk;
   input logic mosi;
   output logic miso;
   input logic ss;

   parameter int clk_polarity;
   parameter int clk_phase;
   parameter logic [7:0] default_byte = 8'hA5;

   event	 sample_ev;
   event	 change_ev;

   logic	 miso_r;
   logic [15:0]  rd_data;
   logic [7:0]	 miso_byte;

   typedef mailbox #(logic [7:0]) spi_inbox_t;
   spi_inbox_t spi_mosi_inbox = new();
   spi_inbox_t spi_miso_inbox = new();

   assign miso = (ss == '1) ? 'Z : miso_r;


   /**************************************************************************
    * Write output data onto the MISO
    * TODO: Allow variable bit width data to be supplied
    **************************************************************************/
   task tx_miso_byte;
      input [7:0] data;

      begin
	 $timeformat(-9, 2, " ns", 20);

	 if(clk_phase == 1) begin
	    @(change_ev);
	 end

	 $display("%t: SPI Slave - Write Data - '%x'", $time, data);

	 // Output MSB
	 miso_r <= data[$bits(data)-1];
	 #1;


	 // Output the rest of the data on the MISO_R line
	 for(int x=$bits(data)-2; x>=0; x--) begin
	    @(change_ev);
	    // Output bit
	    miso_r <= data[x];
	 end
	 @(change_ev);
      end
   endtask


   /**************************************************************************
    * Read data from the MOSI
    * TODO: Allow variable bit width data to be supplied
    **************************************************************************/
   task rx_mosi_byte;
      static logic [7:0] temp_byte = '0;

      begin
	 $timeformat(-9, 2, " ns", 20);

	 wait(ss == '0);

	 // Avoid issue with calling at beginning of the tb
	 #1;

	 if(clk_phase == 1) begin
	    @(change_ev);
	 end

	 @(sample_ev);
	 temp_byte <= {temp_byte[$bits(temp_byte)-2:0], mosi};

	 while(ss == '0) begin
	    // Output the rest of the data on the MOSI line
	    for(int x=0; x<8; x++) begin
	       @(sample_ev or ss);
	       if(ss == '1) begin
		  break;
	       end

	       // Read bit
	       temp_byte <= {temp_byte[$bits(temp_byte)-2:0], mosi};
	    end

	    spi_mosi_inbox.put(temp_byte);
	    $display("%t: SPI Slave - Read Byte - '%b'", $time, temp_byte[7:0]);
	 end

	 // Guarantee 1 step for data to update before returning
	 #1;
      end
   endtask // rx_mosi_byte


   /**************************************************************************
    * Read the latest MOSI byte from the mailbox and return it. [BLOCKING]
    **************************************************************************/
   task get_mosi_byte;
      output logic [7:0] temp_byte;

      begin
	 spi_mosi_inbox.get(temp_byte);

      end
   endtask // get_mosi_byte


   /**************************************************************************
    * Put the supplied byte into the MISO byte mailbox.
    **************************************************************************/
   task put_miso_byte;
      input logic [7:0] temp_byte;

      begin
	 spi_miso_inbox.put(temp_byte);

      end
   endtask // put_miso_byte


   /**************************************************************************
    * Sample event
    *
    * This block is responsible for triggering the sample event at the
    * appropriate clock edge.
    **************************************************************************/
   initial begin
      forever begin
	 if(clk_phase == 0) begin
	    if(clk_polarity == 0) begin
	       @(posedge sclk) ->sample_ev;

	    end else begin
	       @(negedge sclk) ->sample_ev;

	    end
	 end else begin
	    if(clk_polarity == 0) begin
	       @(negedge sclk) ->sample_ev;

	    end else begin
	       @(posedge sclk) ->sample_ev;

	    end
	 end
      end
   end


   /**************************************************************************
    * Data change event
    *
    * This block is responsible for triggering the data event at the
    * appropriate clock edge.
    **************************************************************************/
   initial begin
      forever begin
	 if(clk_phase == 0) begin
	    if(clk_polarity == 0) begin
	       @(negedge sclk) ->change_ev;

	    end else begin
	       @(posedge sclk) ->change_ev;

	    end
	 end else begin
	    if(clk_polarity == 0) begin
	       @(posedge sclk) ->change_ev;

	    end else begin
	       @(negedge sclk) ->change_ev;

	    end
	 end
      end
   end


   /**************************************************************************
    * Main MOSI BFM operation
    **************************************************************************/
   initial begin
      forever begin
	 rx_mosi_byte();
      end
   end


   /**************************************************************************
    * Main MISO BFM operation
    **************************************************************************/
   initial begin
      wait(ss == '0);

      forever begin
	 if(spi_miso_inbox.try_get(miso_byte) != 0) begin
	    tx_miso_byte(miso_byte);

	 end else begin
	    tx_miso_byte(default_byte);

	 end
      end
   end
endmodule // spi_slave_bfm