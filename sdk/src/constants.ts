import { Inputs } from '@mysten/sui/transactions';

export const OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0xb645644c3af68fd88dab769d092b46f1759f69598c1565154bdffc39bc21c5e8',
    initialSharedVersion: '89890688',
    mutable: false,
  }),
  ACCOUNT_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0x4668b31e86e4937c601c345f169b1cc814d03f64c5bd79b4ea9df3d12cfb5a5b',
    mutable: true,
    initialSharedVersion: '89890689',
  }),

  SUPER_ADMIN:
    '0x3d225dfe44e070316a0516babdc1c77b914567ee84acbbbec3e97931b2968efd',
  ADMIN: '0xb4c56302d1e2ea83295a0ca453c9ad43f4f3a6f01588c2598bf9cb909dae9c0e',
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0xc01627679c9465a6bf77fd75a18f09dfd3d1216055b2dcad0cf45aa286ddc25d',
    mutable: false,
    initialSharedVersion: '89890690',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x0b4bd22a973570939c29a0c4ef4832a4829e2f92cdab569edcbe4a9173c674c0',
    mutable: false,
    initialSharedVersion: '89890690',
  }),
  AVATAR_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0x442d36b4c31222c672443ba77647f305c19a6adf1c760f96b6679107ca760303',
    mutable: true,
    initialSharedVersion: '89890690',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0x587713ef28620278bda42292c619ef138a905e368c47735705160aa056eacbc1',
    mutable: true,
    initialSharedVersion: '89890690',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0xe8a6075cea4b51cfbd2c4499e4607d8b2d4be3a0ea3a77373ee213c5374ee52c',
    mutable: false,
    initialSharedVersion: '89890690',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x91f9050562bb7098486c7373f2c254b5e1697f7853dd8c6c6b981ff853f39eef',
    mutable: false,
    initialSharedVersion: '89890690',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0x943a51661c71318bf4f4537ddc2cfa58165ea8ff99c17521e26e78c631e25adb',
    mutable: true,
    initialSharedVersion: '89890690',
  }),
  GENESIS_SHOP_ITEMS_ID:
    '0x37684b8d97b296940d80db9581c93c829daba006f5b1dd0e38cdb5d3d7bbc662',
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0xc6d1693a757beb4c275195fcc6dc699f90eb33ad4bafc638e97d228cbe50a6b9',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0xe60d0ab8e7c2297004cd663e2c8e9feca33efb47263d78cab04ad7a7b306c059',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0x60a87487e12e8e2993d87cd8d3be8b18b3477b2e39c4b8d69d8aca540c110d04',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0x4131664ba5171fd9bced996b37238d7b541436a13d4d32ecce245f221c5ed9d8',
  ANIMA: '0x81d09a79969ff82ae4d8ec3e0371cece69023f6755b4184e7c869216211dbe5a',
  ACT: '0x08388e6edf9daea1e50cf7254d022ba3b850669d6cd21a6503af79d67bb36bf0',
};

export const GENESIS_SHOP_NAMES = {
  CHESTPIECE: { type: '0x1::string::String', value: 'Chestpiece' },
  RIGHT_GLOVE: { type: '0x1::string::String', value: 'Right Glove' },
  TERTIARY: { type: '0x1::string::String', value: 'Tertiary' },
  SHINS: { type: '0x1::string::String', value: 'Shins' },
  RIGHT_PAULDRON: { type: '0x1::string::String', value: 'Right Pauldron' },
  LEFT_BRACER: { type: '0x1::string::String', value: 'Left Bracer' },
  LEGS: { type: '0x1::string::String', value: 'Legs' },
  LEFT_ARM: { type: '0x1::string::String', value: 'Left Arm' },
  UPPER_TORSO: { type: '0x1::string::String', value: 'Upper Torso' },
  RIGHT_BRACER: { type: '0x1::string::String', value: 'Right Bracer' },
  SECONDARY: { type: '0x1::string::String', value: 'Secondary' },
  HELM: { type: '0x1::string::String', value: 'Helm' },
  LEFT_PAULDRON: { type: '0x1::string::String', value: 'Left Pauldron' },
  PRIMARY: { type: '0x1::string::String', value: 'Primary' },
  LEFT_GLOVE: { type: '0x1::string::String', value: 'Left Glove' },
  BOOTS: { type: '0x1::string::String', value: 'Boots' },
  RIGHT_ARM: { type: '0x1::string::String', value: 'Right Arm' },
  BELT: { type: '0x1::string::String', value: 'Belt' },
};
