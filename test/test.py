import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_trng(dut):

    dut._log.info("Starting TRNG Test")

    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 50)

    dut._log.info(f"Random Output: {dut.uo_out.value}")

    assert dut.uo_out.value is not None
