// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {WeirdToken} from "../src/WeirdToken.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";

import {MockERC4626} from "solmate/test/utils/mocks/MockERC4626.sol";


contract WeirdTokenTest is Test, WeirdToken {
    address bob = makeAddr("bob");
    MockERC4626 vault;

    function testWeirdTokenDeposit() public useWeirdToken {
        vault = new MockERC4626(ERC20(address(weirdERC20)), weirdERC20_NAME, weirdERC20_NAME);
        deal(address(weirdERC20), bob, 1_000_000);

        vm.startPrank(bob);
        weirdERC20.approve(address(vault), 1_000_000);
        vault.deposit(100, bob);
        vm.stopPrank();
    }
}
