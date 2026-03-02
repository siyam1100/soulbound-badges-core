# Soulbound Badges Core

This repository provides a specialized implementation of the ERC-721 standard where the `transfer` functionality is disabled. This creates a "Soulbound" token that is permanently linked to a specific wallet address.

### Use Cases
* **Educational Credentials:** Proof of course completion or degree.
* **DAO Reputation:** Badges for active governance participants.
* **KYC/AML:** On-chain verification that a user has passed compliance.
* **Gaming:** Unlocking non-tradable achievements or skins.

### Security Features
* **Non-Transferable:** Overrides `_update` to prevent tokens from leaving the original mint address.
* **Burnable:** Allows the issuer or the holder to "burn" the token if needed.
* **Metadata management:** Supports URI storage for off-chain badge assets (IPFS).
