### Configure The Sale

1.  `setStartTimes` to set the sales time
2.  `setMaxMints` to set the maximum NFTs per phase
3.  `setPrices` to set the price per NFT in Sui. Each Sui coin has 9 decimals
4.  `setDropsLeft` set total items to sell. Maximum is 3000

### Give passes for the sale phase

1.  `airdropFreeMint` to allow users to mint an NFT for free in the first phase
2.  `airdropWhitelist` to allow users to mint an NFT for free in the second phase
3.  The third phase does not require a pass as it is open to the public

### How to mint an avatar with items (NEEDS FIXING on step 2 but can be tested now)

1.  `mintToTicket` it sends an AvatarTicket to the user
2.  `generateImageUrlToAvatarTicket` The user needs to update the image on the ticket
3.  `mintToAvatar` To convert the ticket into the avatar with equipped items

### How to mint items to the kiosk

- `mintToKiosk` to mint items and put them in the kiosk

### Anima Account

- `newAnimaAccount` to create an new account
- `updateAlias` to update the account alias
- `updateUsername` to update the account user name

### Query Operations

- `getAvatarItems` returns the equipped items in the avatar
- `getPersonalKiosks` get all personal kiosks owned by an address
- `getItemsInKiosk` get all weapons/cosmetics an address has in a kiosk
- `getAvatar` to get a user avatar
- `getAvatarTicket` to get an AvatarTicket
- `getGenesisShopItems` get the items in the genesis shop per category
- `getGenesisPasses` gets all the genesis passes

  ### Avatar Operations

  - `equipWeapons` moves weapons from a kiosk to an avatar
  - `unequipWeapons` moves weapons from an avatar to a kiosk
  - `equipCosmetics` moves cosmetics from a kiosk to an avatar
  - `unequipCosmetics` moves cosmetics from an avatar to a kiosk

  ### Reputation Operations

  - `giveReputation` a user with an account can send a reputation to another account address
  - `removeReputation` an admin can remove a reputation from an account address
  - `addAccolade` an admin can give an accolade to an account address
  - `removeAccolade` an admin can remove an accolade

    ### Avatar Image Operations

    - `newAvatarImage` an admin can send an image to an Avatar
    - `updateAvatar` a user calls update avatar to update the image sent by the admin

    ### Upgrade Operations

    - `newUpgrade` an admin can send an upgrade to an Avatar/Weapon/Cosmetic address
    - `upgradeAvatar` a user can upgrade his/her/their avatar after getting an upgrade
    - `upgradeAvatarWeapon` a user can upgrade his/her/their avatar after getting an upgrade
    - `upgradeAvatarCosmetic` a user can upgrade his/her/their avatar after getting an upgrade
