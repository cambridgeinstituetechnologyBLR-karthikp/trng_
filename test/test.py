import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_project(dut):

    dut._log.info("Start TRNG test")

    await Timer(200, units="ns")

    dut._log.info(f"Random output = {dut.uo_out.value}")

    assert dut.uo_out.value.integer >= 0
