package mylib

import spinal.core._

// Hardware definitions
case class MyTopLevel() extends Component {
  val io = new Bundle { 
    val enable = in Bool()
    val led = out Bool() 
  }
  
  val ledReg = Reg(Bool()) 
  ledReg := io.enable
  io.led := ledReg
}

object MyTopLevelVerilog extends App {
  Config.spinal.generateVerilog(MyTopLevel())
}

object MyTopLevelVhdl extends App {
  Config.spinal.generateVhdl(MyTopLevel())
}
