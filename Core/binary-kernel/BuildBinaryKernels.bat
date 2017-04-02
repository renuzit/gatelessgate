@rem GCN1: CapeVerde, Pitcairn, Tahiti, Oland, Hainan
@rem GCN2: Bonaire, Hawaii, Mullins
@rem GCN3: Tonga, Fiji, Carrizo
@rem GCN4: Ellesmere, Baffin
@rem ?: Spectre, Spooky, Kalindi, Iceland, Goose, Horse, Stoney

del *.bin

@rem Windiws 

clrxasm equihash-gcn1-amdcl-32bit.asm -g CapeVerde -o equihashCapeverdegw256l4.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Pitcairn -o equihashPitcairngw256l4.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Tahiti -o equihashTahitigw256l4.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Oland -o equihashOlandgw256l4.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Hainan -o equihashHainangw256l4.bin

clrxasm ethash-new-gcn3-amdcl2.asm -g Tonga -o ethash-newTongagw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Fiji -o ethash-newFijigw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Carrizo -o ethash-newCarrizogw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Ellesmere -o ethash-newEllesmeregw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Baffin -o ethash-newBaffingw192l4.bin

clrxasm ethash-new-gcn3-amdcl2.asm -g Iceland -o ethash-newIcelandgw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Goose -o ethash-newGoosegw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Horse -o ethash-newHorsegw192l4.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Stoney -o ethash-newStoneygw192l4.bin

@rem Linux

clrxasm equihash-gcn1-amdcl-32bit.asm -g CapeVerde -o equihashCapeverdegw256l8.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Pitcairn -o equihashPitcairngw256l8.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Tahiti -o equihashTahitigw256l8.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Oland -o equihashOlandgw256l8.bin
clrxasm equihash-gcn1-amdcl-32bit.asm -g Hainan -o equihashHainangw256l8.bin

clrxasm ethash-new-gcn3-amdcl2.asm -g Tonga -o ethash-newTongagw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Fiji -o ethash-newFijigw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Carrizo -o ethash-newCarrizogw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Ellesmere -o ethash-newEllesmeregw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Baffin -o ethash-newBaffingw192l8.bin

clrxasm ethash-new-gcn3-amdcl2.asm -g Iceland -o ethash-newIcelandgw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Goose -o ethash-newGoosegw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Horse -o ethash-newHorsegw192l8.bin
clrxasm ethash-new-gcn3-amdcl2.asm -g Stoney -o ethash-newStoneygw192l8.bin

pause
