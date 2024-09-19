async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // ใช้ `getContractFactory` เพื่อสร้างฟาเบอร์รี่ของสัญญา
    const RegisterDisaster = await ethers.getContractFactory("RegisterDisaster");

    // สร้างอินสแตนซ์ของสัญญา
    const registerDisaster = await RegisterDisaster.deploy();

    // รอให้สัญญาถูก deploy เสร็จสมบูรณ์
    await registerDisaster.waitForDeployment();

    // แสดงที่อยู่ของสัญญาที่ deploy เสร็จ
    console.log("RegisterDisaster deployed to:", registerDisaster.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
