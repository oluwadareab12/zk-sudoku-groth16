// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

interface IVerifier {
    function verifyProof(
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[1] calldata input
    ) external view returns (bool);
}

contract VerifySudoku is Script {
    function run() external view {
        address verifierAddr = 0x9fA7EDfF78aeBE19483f3Bd3378272463bdf52A6;
        IVerifier verifier = IVerifier(verifierAddr);

        // === VALUES FROM proof.json ===
        uint256[2] memory a = [
            uint256(0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA),
            uint256(0xBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB)
        ];

        uint256[2][2] memory b = [
            [
                uint256(0xCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC),
                uint256(0xDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD)
            ],
            [
                uint256(0xEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE),
                uint256(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            ]
        ];

        uint256[2] memory c = [
            uint256(0x1111111111111111111111111111111111111111111111111111111111111111),
            uint256(0x2222222222222222222222222222222222222222222222222222222222222222)
        ];

        // === FROM public.json ===
        uint256[1] memory input = [
            uint256(0)
        ];

        bool ok = verifier.verifyProof(a, b, c, input);

        console.log("Sudoku proof valid:", ok);
    }
}
