----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:39 12/29/2021 
-- Design Name: 
-- Module Name:    mangler - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mangler is
    Port ( CFGPINS : in STD_LOGIC_VECTOR (2 downto 0);
           --LPC_RST : in  STD_LOGIC;
           LPC_CLK : in  STD_LOGIC;
           LPC_FRM : in  STD_LOGIC;
           LPC_LAD : inout  STD_LOGIC_VECTOR (3 downto 0);
           SL_FRM : out  STD_LOGIC;
           SL_LAD : inout  STD_LOGIC_VECTOR (3 downto 0));
end mangler;

architecture Behavioral of mangler is

   TYPE SL_STATE_MACHINE IS (
   SL_WAIT, 
   SL_START, 
   SL_DIR,
   SL_ADDRESS,
   SL_WRITE_DATA0,
   SL_WRITE_DATA1,
   SL_READ_DATA0,
   SL_READ_DATA1,
   SL_TAR1, 
   SL_TAR2, 
   SL_SYNCING, 
   SL_SYNC_COMPLETE, 
   SL_TAR_EXIT,
   SL_ABORT
   );

   TYPE LPC_STATE_MACHINE IS (
   INITIALIZE,
   WAIT_START, 
   CYCTYPE_DIR, 
   ADDRESS, 
   WRITE_DATA,
   READ_DATA0,
   READ_DATA1,
   TAR1, 
   TAR2, 
   SYNCING, 
   SYNC_COMPLETE, 
   TAR_EXIT
   );
 
   TYPE CYC_TYPE IS (
   IO_READ, --Default state
   IO_WRITE, 
   MEM_READ, 
   MEM_WRITE
   );

   SIGNAL SL_CURRENT_STATE : SL_STATE_MACHINE := SL_ABORT;
   SIGNAL SL_CYCLE : STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL LPC_CURRENT_STATE : LPC_STATE_MACHINE := INITIALIZE;
   attribute fsm_encoding : string;
   attribute fsm_encoding of LPC_CURRENT_STATE : signal is "sequential";
   SIGNAL CYCLE_TYPE : CYC_TYPE;
   SIGNAL SL_ADDR : STD_LOGIC_VECTOR (3 DOWNTO 0);

   SIGNAL READBUFFER : STD_LOGIC_VECTOR (7 DOWNTO 0); --I buffer Memory and IO reads to reduce pin to pin delay in CPLD which caused issues
   SIGNAL WRITEBUFFER : STD_LOGIC_VECTOR (7 DOWNTO 0);
 
   --GENERIC COUNTER USED TO TRACK ADDRESS AND SYNC COUNTERS.
   SIGNAL LPC_COUNT : INTEGER RANGE 0 TO 7;
   SIGNAL LPC_READY : STD_LOGIC_VECTOR (3 DOWNTO 0);

   SIGNAL SOFTCFG : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0111";
   SIGNAL BYPASS : STD_LOGIC;

BEGIN
   --LAD lines can be either input or output
   --The output values depend on variable states of the LPC transaction
   --Refer to the Intel LPC Specification Rev 1.1
   LPC_LAD(3 DOWNTO 0) <= LPC_READY WHEN LPC_CURRENT_STATE = SYNC_COMPLETE ELSE
              LPC_READY WHEN LPC_CURRENT_STATE = SYNCING ELSE
              "1111" WHEN LPC_CURRENT_STATE = TAR2 ELSE
              "1111" WHEN LPC_CURRENT_STATE = TAR_EXIT ELSE
              READBUFFER(3 DOWNTO 0) WHEN LPC_CURRENT_STATE = READ_DATA0 ELSE --This has to be lower nibble first!
              READBUFFER(7 DOWNTO 4) WHEN LPC_CURRENT_STATE = READ_DATA1 ELSE 
              "ZZZZ";
   
   -- Slave LAD lines mirror Host LAD lines two clocks behind unless modified
   SL_LAD <= "0000" WHEN SL_CURRENT_STATE = SL_START ELSE
            SL_CYCLE WHEN SL_CURRENT_STATE = SL_DIR ELSE
            "1111" WHEN SL_CURRENT_STATE = SL_ABORT ELSE
            "1111" WHEN SL_CURRENT_STATE = SL_TAR1 ELSE
            SL_ADDR WHEN SL_CURRENT_STATE = SL_ADDRESS ELSE
            WRITEBUFFER(3 DOWNTO 0) WHEN SL_CURRENT_STATE = SL_WRITE_DATA0 ELSE
            WRITEBUFFER(7 DOWNTO 4) WHEN SL_CURRENT_STATE = SL_WRITE_DATA1 ELSE
              "ZZZZ";

   SL_FRM <= '0' WHEN SL_CURRENT_STATE = SL_START ELSE
             '0' WHEN SL_CURRENT_STATE = SL_ABORT ELSE
		     '1';
 
PROCESS (LPC_CLK) BEGIN
   IF (rising_edge(LPC_CLK)) THEN
      IF LPC_FRM = '0' THEN
         IF LPC_LAD(3 DOWNTO 0) = "0000" THEN
            LPC_CURRENT_STATE <= CYCTYPE_DIR;
            SL_CURRENT_STATE <= SL_START;
         ELSE
            LPC_CURRENT_STATE <= WAIT_START;
            SL_CURRENT_STATE <= SL_ABORT;
         END IF;
      END IF;
      CASE SL_CURRENT_STATE IS
         WHEN SL_ABORT =>
            SL_CURRENT_STATE <= SL_WAIT;
         WHEN SL_READ_DATA0 =>
            READBUFFER(3 DOWNTO 0) <= SL_LAD(3 DOWNTO 0);
            SL_CURRENT_STATE <= SL_READ_DATA1;
         WHEN SL_READ_DATA1 =>
            READBUFFER(7 DOWNTO 4) <= SL_LAD(3 DOWNTO 0);
            SL_CURRENT_STATE <= SL_TAR_EXIT;
         WHEN SL_WRITE_DATA0 =>
         WHEN SL_WRITE_DATA1 =>
         WHEN SL_TAR1 =>
            SL_CURRENT_STATE <= SL_TAR2;
         WHEN SL_TAR2 =>
         WHEN SL_TAR_EXIT =>
            SL_CURRENT_STATE <= SL_WAIT;
         WHEN SL_WAIT =>
         WHEN SL_START =>
         WHEN SL_DIR =>
         WHEN SL_ADDRESS =>
         WHEN SL_SYNCING =>
         WHEN SL_SYNC_COMPLETE =>
      END CASE;
      
      CASE LPC_CURRENT_STATE IS
         WHEN INITIALIZE =>
            SOFTCFG(2 DOWNTO 0) <= CFGPINS(2 DOWNTO 0);
            LPC_CURRENT_STATE <= WAIT_START;
         WHEN WAIT_START =>
         WHEN CYCTYPE_DIR => 
            SL_CURRENT_STATE <= SL_DIR;
            LPC_CURRENT_STATE <= ADDRESS;
            SL_CYCLE(3 DOWNTO 0) <= LPC_LAD(3 DOWNTO 0);
            
            IF LPC_LAD(3 DOWNTO 1) = "010" THEN
               CYCLE_TYPE <= MEM_READ;
               LPC_COUNT <= 7;
            ELSIF LPC_LAD(3 DOWNTO 1) = "011" THEN
               CYCLE_TYPE <= MEM_WRITE;
               LPC_COUNT <= 7;
            ELSIF LPC_LAD(3 DOWNTO 1) = "001" THEN
               CYCLE_TYPE <= IO_WRITE;
               SL_CURRENT_STATE <= SL_ABORT;
               LPC_COUNT <= 3;
            ELSIF LPC_LAD(3 DOWNTO 1) = "000" THEN
               CYCLE_TYPE <= IO_READ;
               SL_CURRENT_STATE <= SL_ABORT;
               LPC_COUNT <= 3;
            ELSE
               LPC_CURRENT_STATE <= WAIT_START; -- Unsupported, reset state machine.
               SL_CURRENT_STATE <= SL_ABORT;
            END IF;
 
         --ADDRESS GATHERING
         WHEN ADDRESS =>
            IF CYCLE_TYPE = MEM_READ OR CYCLE_TYPE = MEM_WRITE THEN
               SL_CURRENT_STATE <= SL_ADDRESS;
            END IF;

            SL_ADDR(3 DOWNTO 0) <= LPC_LAD(3 DOWNTO 0);
            IF LPC_COUNT = 6 AND LPC_LAD(3 DOWNTO 0) = "1111" THEN -- A27:A24
               SL_ADDR(1 DOWNTO 0) <= "00"; -- '160 Chips 12-15
            ELSIF LPC_COUNT = 5 THEN -- A23:A20
               BYPASS <= '0';
               IF LPC_LAD(3 DOWNTO 1) = "111" OR LPC_LAD(3 DOWNTO 1) = "000" THEN -- BOOT WINDOW 01/EF
                  SL_ADDR(3 DOWNTO 1) <= "010"; -- '160 Chip 15 (U1)
                  SL_ADDR(0) <= SOFTCFG(1); -- 1MB Bank Select
               ELSIF LPC_LAD(3 DOWNTO 1) = "110" OR LPC_LAD(3 DOWNTO 1) = "100" OR LPC_LAD(3 DOWNTO 1) = "011" OR LPC_LAD(3 DOWNTO 1) = "001" THEN
                  BYPASS <= '1';
                  SL_ADDR(3) <= '0';
               END IF;
            ELSIF LPC_COUNT = 4 AND BYPASS = '0' THEN -- A19:A16
               IF SOFTCFG(2) = '0' THEN -- 512K Banks
                  SL_ADDR(3) <= SOFTCFG(0); -- 512K Bank Select
               END IF;
            ELSIF CYCLE_TYPE = IO_READ THEN
               IF LPC_COUNT = 0 AND LPC_LAD(3 DOWNTO 1) = "111" THEN
                  LPC_CURRENT_STATE <= TAR1;
                  IF LPC_LAD(0) = '1' THEN
                     READBUFFER(7 DOWNTO 0) <= "10101010";
                  ELSE
                     READBUFFER(7) <= '0';
                     READBUFFER(6 DOWNTO 4) <= CFGPINS(2 DOWNTO 0);
                     READBUFFER(3 DOWNTO 0) <= SOFTCFG(3 DOWNTO 0);
                  END IF;
               ELSIF LPC_COUNT = 1 AND LPC_LAD(3 DOWNTO 0) = "1110" THEN
               ELSIF (LPC_COUNT = 2 OR LPC_COUNT = 3) AND LPC_LAD(3 DOWNTO 0) = "0000" THEN
               ELSE
                  LPC_CURRENT_STATE <= WAIT_START;
               END IF;
            ELSIF CYCLE_TYPE = IO_WRITE THEN
               IF LPC_COUNT = 0 AND LPC_LAD(3 DOWNTO 0) = "1111" THEN
                  LPC_CURRENT_STATE <= WRITE_DATA;
               ELSIF LPC_COUNT = 1 AND LPC_LAD(3 DOWNTO 0) = "1110" THEN
               ELSIF LPC_LAD(3 DOWNTO 0) = "0000" THEN
               ELSE
                  LPC_CURRENT_STATE <= WAIT_START;
               END IF;
            ELSIF LPC_COUNT = 0 THEN
               LPC_CURRENT_STATE <= WAIT_START;
               
               -- catch unsupported IO read/writes here before they modify LAD
               IF CYCLE_TYPE = MEM_READ THEN
                  LPC_CURRENT_STATE <= TAR1;
               ELSIF CYCLE_TYPE = MEM_WRITE THEN
                  LPC_CURRENT_STATE <= WRITE_DATA;
               END IF;
            END IF;
            LPC_COUNT <= LPC_COUNT - 1;
 
         -- MEMORY OR IO WRITES. These all happen lower nibble first. (Refer to Intel LPC spec)
         -- HACK: abuses counter rollover from previous state
         WHEN WRITE_DATA => 
            IF CYCLE_TYPE = IO_WRITE THEN
               IF LPC_COUNT = 7 THEN
                  SOFTCFG(3 DOWNTO 0) <= LPC_LAD(3 DOWNTO 0);
               END IF;
            ELSIF CYCLE_TYPE = MEM_WRITE THEN
               IF LPC_COUNT = 7 THEN
                  WRITEBUFFER(3 DOWNTO 0) <= LPC_LAD(3 DOWNTO 0);
                  SL_CURRENT_STATE <= SL_WRITE_DATA0;
               ELSE
                  WRITEBUFFER(7 DOWNTO 4) <= LPC_LAD(3 DOWNTO 0);
                  SL_CURRENT_STATE <= SL_WRITE_DATA1;
               END IF;
            END IF;
            
            IF LPC_COUNT = 6 THEN
               LPC_CURRENT_STATE <= TAR1;
            END IF;
            LPC_COUNT <= LPC_COUNT - 1; 

         --MEMORY OR IO READS
         WHEN READ_DATA0 => 
            IF CYCLE_TYPE = MEM_READ THEN
               READBUFFER(7 DOWNTO 4) <= SL_LAD(3 DOWNTO 0);
            END IF;
            LPC_CURRENT_STATE <= READ_DATA1;
         WHEN READ_DATA1 => 
            LPC_CURRENT_STATE <= TAR_EXIT; 

         --TURN BUS AROUND (HOST TO PERIPHERAL)
         WHEN TAR1 => 
            LPC_CURRENT_STATE <= TAR2;
			LPC_READY(3 DOWNTO 0) <= "0101";
            IF CYCLE_TYPE = MEM_READ OR CYCLE_TYPE = MEM_WRITE THEN
              SL_CURRENT_STATE <= SL_TAR1;
            END IF;
         WHEN TAR2 => 
            LPC_CURRENT_STATE <= SYNCING;
			LPC_READY(3 DOWNTO 0) <= "0101";
            IF CYCLE_TYPE = MEM_READ OR CYCLE_TYPE = MEM_WRITE THEN
               LPC_READY(3 DOWNTO 0) <= SL_LAD(3 DOWNTO 0);
            END IF;
            
         --SYNCING STAGE
         WHEN SYNCING =>
            IF CYCLE_TYPE = IO_WRITE OR CYCLE_TYPE = IO_READ THEN
               LPC_READY(3 DOWNTO 0) <= "0000";
               LPC_CURRENT_STATE <= SYNC_COMPLETE;
            ELSIF CYCLE_TYPE = MEM_READ OR CYCLE_TYPE = MEM_WRITE THEN
               LPC_READY(3 DOWNTO 0) <= SL_LAD(3 DOWNTO 0);
			   IF SL_LAD(3 DOWNTO 0) = "0000" THEN
                  LPC_CURRENT_STATE <= SYNC_COMPLETE;
			   ELSIF SL_LAD(3 DOWNTO 0) = "1010" THEN
                  LPC_CURRENT_STATE <= TAR_EXIT;
			   END IF;
            END IF;
         WHEN SYNC_COMPLETE => 
            IF CYCLE_TYPE = IO_READ THEN
               LPC_CURRENT_STATE <= READ_DATA0;
            ELSIF CYCLE_TYPE = MEM_READ THEN
               READBUFFER(3 DOWNTO 0) <= SL_LAD(3 DOWNTO 0);
               LPC_CURRENT_STATE <= READ_DATA0;
            ELSE
               LPC_CURRENT_STATE <= TAR_EXIT;
            END IF;
 
         --TURN BUS AROUND (PERIPHERAL TO HOST)
         WHEN TAR_EXIT => 
            LPC_CURRENT_STATE <= WAIT_START;
      END CASE;
   END IF;
END PROCESS;

end Behavioral;

