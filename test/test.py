import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_project(dut):

    dut.ui_in.value = 5
    dut.uio_in.value = 0

    await Timer(1, units="ns")

    assert dut.uo_out.value == 5
