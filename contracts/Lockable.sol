pragma solidity ^0.4.0;

contract Lockable {
    uint public numOfCurrentEpoch;
    uint public creationTime;
    uint public constant UNLOCKED_TIME = 25 days;
    uint public constant LOCKED_TIME = 5 days;
    uint public constant EPOCH_LENGTH = 30 days;
    bool public lock;
    bool public tokenSwapLock;

    event Locked();
    event Unlocked();

    // This modifier should prevent tokens transfers while the tokenswap
    // is still ongoing
    modifier isTokenSwapOn {
        if (tokenSwapLock) throw;
        _;
    }

    // This modifier checks and, if needed, updates the value of current
    // token contract epoch, before executing a token transfer of any
    // kind
    modifier isNewEpoch {
        if (numOfCurrentEpoch * EPOCH_LENGTH + creationTime < now ) {
            numOfCurrentEpoch = (now - creationTime) / EPOCH_LENGTH + 1;
        }
        _;
    }

    // This modifier check whether the contract should be in a locked
    // or unlocked state, then acts and updates accordingly if
    // necessary
    modifier checkLock {
        if ((creationTime + numOfCurrentEpoch * UNLOCKED_TIME) +
        (numOfCurrentEpoch - 1) * LOCKED_TIME < now) {
            // avoids needless lock state change and event spamming
            if (lock) throw;

            lock = true;
            Locked();
            return;
        }
        else {
            // only set to false if in a locked state, to avoid
            // needless state change and event spam
            if (lock) {
                lock = false;
                Unlocked();
            }
        }
        _;
    }

    function Lockable() {
        creationTime = now;
        numOfCurrentEpoch = 1;
        tokenSwapLock = true;
    }
}
