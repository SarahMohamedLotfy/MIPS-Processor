library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity BranchHazard is 
generic (
         RBits    :integer:=3;
         RtBits   :integer:=3;
         selector :integer:=3);
    port(
        reset            : in  std_logic:='0';
        clk,JZ,CALL_JMP              : in  std_logic;
        Rs_instr_fetch   : in std_logic_vector(RBits-1 downto 0); --1
        Reg_write_decode : in std_logic;--2
        RegDst_decode    : in std_logic;--3
        Reg_Rd_EX        : in std_logic_vector(RBits-1 downto 0);--4
        Rs_instr_decode  : in std_logic_vector(RBits-1 downto 0);--5
        Rd_instr_decode  : in std_logic_vector(RBits-1 downto 0);--6
        ID_EX_RegWrite   : in std_logic;--7
        ID_EX_instr_Rs   : in std_logic_vector(RBits-1 downto 0); --8
        ID_EX_instr_Rd   : in std_logic_vector(RBits-1 downto 0); --9
        Rd_decode        : in std_logic_vector(RBits-1 downto 0); --10
        Swap_decode      : in std_logic;--11
        ID_EX_swap       : in std_logic;--12
        Decode_MemRead,ExeMemRead,Mem_memRead:in std_logic;
        MemRegRd:in std_logic_vector(2 downto 0);
        PC_write         : out std_logic;
        IF_ID_flush      : out std_logic;
        Target_Selector  : out std_logic_vector(selector-1 downto 0)

        ); 
     
     
end BranchHazard;

architecture BranchHazardArch of BranchHazard is 

begin

PC_write <='0' when (((Reg_write_decode='1' or Decode_MemRead='1')and RegDst_decode='0' and Rd_instr_decode=Rs_instr_fetch) 
or ((Reg_write_decode='1' or Decode_MemRead='1') and RegDst_decode='1' and Rs_instr_decode=Rs_instr_fetch)
or ( ExeMemRead='1' and Reg_Rd_EX=Rs_instr_fetch))
and (JZ='1' or CALL_JMP='1') else '1' 
when((ID_EX_RegWrite='1' and Reg_Rd_EX=Rs_instr_fetch) 
or(Swap_decode='1' and Rs_instr_decode=Rs_instr_fetch)
 or (Swap_decode='1' and Rs_instr_fetch=Rd_decode)
 or(ID_EX_swap='1' and ID_EX_instr_Rs=Rs_instr_fetch)
 or (ID_EX_swap='1' and ID_EX_instr_Rd=Rs_instr_fetch) )and (JZ='1' or CALL_JMP='1') else '1';


 IF_ID_flush<='1' when (((Reg_write_decode='1' or Decode_MemRead='1')and RegDst_decode='0' and Rd_instr_decode=Rs_instr_fetch) 
 or ((Reg_write_decode='1' or Decode_MemRead='1') and RegDst_decode='1' and Rs_instr_decode=Rs_instr_fetch)
 or ( ExeMemRead='1' and Reg_Rd_EX=Rs_instr_fetch))
 and (JZ='1' or CALL_JMP='1') else '0' 
 when((ID_EX_RegWrite='1' and Reg_Rd_EX=Rs_instr_fetch) 
 or(Swap_decode='1' and Rs_instr_decode=Rs_instr_fetch)
  or (Swap_decode='1' and Rs_instr_fetch=Rd_decode)
  or(ID_EX_swap='1' and ID_EX_instr_Rs=Rs_instr_fetch)
  or (ID_EX_swap='1' and ID_EX_instr_Rd=Rs_instr_fetch) )and (JZ='1' or CALL_JMP='1') else '0';


  Target_Selector <= "111" when  (((Reg_write_decode='1' or Decode_MemRead='1')and RegDst_decode='0' and Rd_instr_decode=Rs_instr_fetch) 
  or ((Reg_write_decode='1' or Decode_MemRead='1') and RegDst_decode='1' and Rs_instr_decode=Rs_instr_fetch)
  or ( ExeMemRead='1' and Reg_Rd_EX=Rs_instr_fetch))
  and (JZ='1' or CALL_JMP='1')
  else "001" when (ID_EX_RegWrite='1' and Reg_Rd_EX=Rs_instr_fetch)and (JZ='1' or CALL_JMP='1')
  else "010" when (Swap_decode='1' and Rs_instr_decode=Rs_instr_fetch)and (JZ='1' or CALL_JMP='1')
  else "011" when (Swap_decode='1' and Rs_instr_fetch=Rd_decode)and (JZ='1' or CALL_JMP='1')
  else "100" when (ID_EX_swap='1' and ID_EX_instr_Rs=Rs_instr_fetch)and (JZ='1' or CALL_JMP='1')
  else "101" when (ID_EX_swap='1' and ID_EX_instr_Rd=Rs_instr_fetch)and (JZ='1' or CALL_JMP='1')
  else "110" when  (Mem_memRead='1' and MemRegRd=Rs_instr_fetch) and (JZ='1' or CALL_JMP='1')
  else "000";
 
   



 
-- process (clk,reset)
-- begin 
-- if(JZ ='1' and rising_edge(clk))then
--     if (Reg_write_decode='1'and RegDst_decode='0' and Rd_instr_decode=Rs_instr_fetch) then 
--         PC_write<='0'; -- stall
--         IF_ID_flush<='1';--flushing
--         Target_Selector<="111";


--     elsif(Reg_write_decode='1' and RegDst_decode='1' and Rs_instr_decode=Rs_instr_fetch) then 
--         PC_write<='0'; -- stall
--         IF_ID_flush<='1';--flushing 
--         Target_Selector<="111";


--     elsif(ID_EX_RegWrite='1' and Reg_Rd_EX=Rs_instr_fetch) then 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="001"; --data out exec 


--     elsif(Swap_decode='1' and Rs_instr_decode=Rs_instr_fetch) then 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="010"; --src2 from decode 

    
--     elsif(Swap_decode='1' and Rs_instr_fetch=Rd_decode) then 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="011"; --src1 from decode 

--     elsif(ID_EX_swap='1' and ID_EX_instr_Rs=Rs_instr_fetch) then 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="100"; --src2 from execute  

--     elsif(ID_EX_swap='1' and ID_EX_instr_Rd=Rs_instr_fetch) then 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="101"; --src1 from execute  

--     else 
--         IF_ID_flush<='0';
--         PC_write<='1'; 
--         Target_Selector<="000"; --normal data from decode   
--     end if;
-- else
-- IF_ID_flush<='0';
-- PC_write<='1'; 
-- Target_Selector<="000"; --normal data from decode   
-- end if;    

-- end process;


end architecture;