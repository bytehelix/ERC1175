// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library NumberCalculator {
    function calculateNumberLength(uint256 number) public pure returns (uint8) {
        uint8 length = 0;
        
        while (number > 0) {
            length++;
            number /= 10;
        }
        
        return length;
    }
    function splitNumber(uint256 number) public pure returns (uint8[] memory) {
        uint256 temp = number;
        uint8 length = calculateNumberLength(number);
        uint8[] memory digits = new uint8[](length);

        for (uint8 i = 0; i < length; i++) {
            digits[i] = uint8(temp % 10);
            temp /= 10;
        }

        return digits;
    }

    function splitNumberWithPadding(uint256 number, uint8 arrayLength) public pure returns (uint8[] memory) {
        uint256 temp = number;
        uint8 length = calculateNumberLength(number);
        require (arrayLength >= length,"arrayLength lt numberLength");
        uint8[] memory digits = new uint8[](arrayLength);
        for (uint8 i = 0; i < length; i++) {
            digits[i] = uint8(temp % 10);
            temp /= 10;
        }
        if (arrayLength > length){
            for (uint8 i = length; i < arrayLength; i++) {
                digits[i] = 0; 
            }
        }
        return digits;
    }
}
