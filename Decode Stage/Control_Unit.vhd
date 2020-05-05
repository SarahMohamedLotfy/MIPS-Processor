library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
generic (n:integer := 32);
port(	
  interrupt: in std_logic;
	reset : in std_logic ; 
	clk: in std_logic ;
	OpCode: in std_logic_vector(5-1 downto 0) ;
	
	 -- nop:0000    A: 0001    B :0010   ALU: 0011 
	 -- Add :0100   Sub:0101   And:0110  Or:0111  SHL:1000  SHR: 1001 
	 
	--Control signals
	RegWrite: out std_logic;
	RegDST: out std_logic;
	MemToReg : out std_logic;
	MemRd : out std_logic;
	MemWR: out std_logic;
	SP: out std_logic_vector(2-1 downto 0) ;
	ALU: out std_logic_vector(4-1 downto 0) ;
	PCWrite: out std_logic;
	IMM_EA: out std_logic;
	sign: out std_logic;
	CRR: out std_logic;
	In_enable: out std_logic;
	Out_enable: out std_logic;
	thirtyTwo_Sixteen :  out std_logic
);
end entity;

architecture Control_Unit_arch of control_unit is
  
begin
process (clk)
begin
if rising_edge(clk) then
   if (reset ='1')then 
     
   
    -- Initialization
    RegWrite <= '0';
	  RegDST <= '0';
	  MemToReg <= '0';
	  MemRd <= '0';
	  MemWR <= '0';
	  SP <= "11";
	  ALU <= "0000";
	  PCWrite <= '0';
	  IMM_EA <= '0';
	  sign <= '0';
	  CRR <= '0';
	  In_enable <= '0';
	  Out_enable <= '0';
	  thirtyTwo_Sixteen<= '0';
    
   else  
    
     --One Operand
     
     --  NOP
     if (OpCode = "00000") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0000";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	    -- NOT
     elsif (OpCode = "00001") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0001";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     
	     -- INC
     elsif (OpCode = "00010") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0001";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     -- DEC
     elsif (OpCode = "00011") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0001";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     -- OUT
     elsif (OpCode = "00100") then
       RegWrite <= '0';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0000";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '1';
	     
	     
	     -- IN
     elsif (OpCode = "00101") then
       RegWrite <= '0';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0000";
	     PCWrite <= '1';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '1';
	     Out_enable <= '0'; 
               
               
     -- Two Operand   
       -- PUSH       
     elsif (OpCode = "01110") then 
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '1';
	     SP <= "00";
	     ALU <= "0010";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     
	     
	     -- POP
     elsif (OpCode = "01111") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '1';
	     MemWR <= '0';
	     SP <= "01";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
	     
	     -- LDM
     elsif (OpCode = "10000") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "10";
	     ALU <= "0010";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='1';
	     
	     
	     -- LDD
     elsif (OpCode = "10001") then 
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '1';
	     MemWR <= '0';
	     SP <= "10";
	     ALU <= "0011";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='1';
	     
	     -- STD
     elsif (OpCode = "10010") then
       RegWrite <= '0';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '1';
	     SP <= "10";
	     ALU <= "0001";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='1';
	     
	     
	     -- JZ
     elsif (OpCode = "10011") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
	     
	     -- JMP
     elsif (OpCode = "10100") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '1';
	     SP <= "00";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
	     
	     
	     -- CALL
     elsif (OpCode = "01101") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '1';
	     SP <= "00";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '1';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
       
     
     --  RET
     elsif (OpCode = "10101") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '1';
	     MemWR <= '0';
	     SP <= "01";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '1';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
	     
	     -- RTI
     elsif (OpCode = "10111") then
       RegWrite <= '0';
	     RegDST <= '0';
	     MemToReg <= '0';
	     MemRd <= '1';
	     MemWR <= '0';
	     SP <= "01";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '1';
	     In_enable <= '0';
	     Out_enable <= '0';
	     thirtyTwo_Sixteen <='0';
	     
	     
     
	     -- SWAP
     elsif (OpCode = "00110") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0000";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     -- ADD
     elsif (OpCode = "00111") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0100";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
       
     -- IADD
     elsif (OpCode = "01000") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0100";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     -- SUB 
     elsif (OpCode = "01001") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0101";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     --AND
     elsif (OpCode = "01010") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "0110";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
	     -- OR
     elsif (OpCode = "01011") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "00";
	     PCWrite <= '0';
	     IMM_EA <= '0';
	     sign <= '0';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
       
       -- SHL
     elsif (OpCode = "01100") then
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "1000";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	    
	    -- SHR 
	  else
       RegWrite <= '1';
	     RegDST <= '1';
	     MemToReg <= '0';
	     MemRd <= '0';
	     MemWR <= '0';
	     SP <= "11";
	     ALU <= "1000";
	     PCWrite <= '0';
	     IMM_EA <= '1';
	     sign <= '1';
	     CRR <= '0';
	     In_enable <= '0';
	     Out_enable <= '0';
	     
                        
      
    
      end if;
   end if;
end if;
end process;
end architecture;



