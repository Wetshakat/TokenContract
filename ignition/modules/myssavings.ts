import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("savingsContractModule", (m) => {
  const mySavings = m.contract("savingsContract",["0x84475dA03D931fc370A22A1c3c41BbdD5AD52f4b"]);

  return { mySavings };
});
 