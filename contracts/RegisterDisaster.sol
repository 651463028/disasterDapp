// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner;   // เก็บข้อมูลของเจ้าของ Smart Contract
    struct Person {
        string idCard;      // รหัสบัตรประชาชน
        string firstName;   // ชื่อ
        string lastName;    // นามสกุล
        string addr;        // ที่อยู่
    }

    Person[] private people; // ตัวแปรเก็บข้อมูลผู้ลงทะเบียน
    mapping(string => uint256) private idToIndex; // แมพของข้อมูลดัชนีของผู้ลงทะเบียนตามรหัสบัตรประชาชน

    // Constructor สำหรับตั้งค่าเจ้าของสัญญา
    constructor() {
        owner = msg.sender;
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(
        string memory _idCard,
        string memory _firstName,
        string memory _lastName,
        string memory _address
    ) public {
        require(idToIndex[_idCard] == 0, "Person already registered"); // ตรวจสอบว่าผู้ที่มี ID นี้ได้ลงทะเบียนแล้ว

        Person memory newPerson = Person({
            idCard: _idCard,
            firstName: _firstName,
            lastName: _lastName,
            addr: _address
        });

        people.push(newPerson);
        idToIndex[_idCard] = people.length; // บันทึกดัชนีของผู้ลงทะเบียน
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด
    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of bounds"); // ตรวจสอบว่า index อยู่ในช่วงที่ถูกต้อง
        return people[index];
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    function getID(string memory _idCard) public view returns (Person memory) {
        uint256 index = idToIndex[_idCard];
        require(index > 0, "Person not found"); // ตรวจสอบว่าผู้ที่มี ID นี้ได้ลงทะเบียนแล้ว
        return people[index - 1];
    }
}
