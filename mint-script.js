const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  const BADGE_URI = "ipfs://Qm...metadata.json";
  const RECIPIENT = "0x..."; 

  const Badge = await hre.ethers.getContractFactory("SoulboundBadge");
  const badge = await Badge.attach("0x..."); // Replace with deployed address

  const tx = await badge.safeMint(RECIPIENT, BADGE_URI);
  await tx.wait();

  console.log(`Badge minted to ${RECIPIENT}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
