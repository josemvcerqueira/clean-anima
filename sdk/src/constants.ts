import { Inputs } from '@mysten/sui/transactions';

export const OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0x1372d2cbf462b7bb1575fb4722b4f8952c8ccc9c7416097cda12f7a49e0c2b65',
    initialSharedVersion: '102635432',
    mutable: true,
  }),
  SYSTEM: Inputs.SharedObjectRef({
    objectId:
      '0x707e001ff69c168fcb34ac3d82019b177292499e70686d013e95d3f3e27f7736',
    mutable: true,
    initialSharedVersion: '102635433',
  }),
  ADMIN: '0x7e252d0b310eafd561f260b8d7edede4cda271a06f7f273ad6cd9b5e8bb144fc',
  SUPER_ADMIN:
    '0x4b83072ab2a32a1ad618c928051648a5a1050e2cd3a974e15ae849c38d09afeb',
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x8837aa5f113c24575da8106a072e843460d8f7ef946ded9e9f0ff6695fed4ae3',
    mutable: false,
    initialSharedVersion: '102635434',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x8c2cb174c3eddaa2d80496a9cd33107369c620fe9ec84729e6b27b356544f313',
    mutable: false,
    initialSharedVersion: '102635434',
  }),
  AVATAR_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0xc1ab6248023972dcac548114f403c8a9de212833716ec95f349b5c919fb1f713',
    mutable: true,
    initialSharedVersion: '102635434',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0x1480edf2eb22ba54845933d947247ed34d057b0ede89a6ce2c977f9f721d6fb6',
    mutable: true,
    initialSharedVersion: '102635434',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x4352803028f8094026cb1455cc7e5589e585f04ef2f5f246b12cbd28a43fdc0f',
    mutable: false,
    initialSharedVersion: '102635434',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0xbd0f3f33539d9c55fa9c0822980a5988135be66fc74998dc1947846096418bd2',
    mutable: false,
    initialSharedVersion: '102635434',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0xb0c79d669d83d596cb872328783873c164b8ef4a06c83f84f2522b885c92be87',
    mutable: true,
    initialSharedVersion: '102635434',
  }),
  GENESIS_SHOP_ITEMS_ID:
    '0x3d7cf022df50ceae39130e1a04ed29c66efeab9d0579ff5366e9f6a588b22540',
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0x13409a2ac80ff5b33db0cf7813b8dcd141bd783e6e516c57e750ca678b16d7f8',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0x5a46c24abf19a42ec72a9acbf58a626a95315d1589b7faeaedd7e9f6e58b2dc5',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0x451e86b1f0ecb31c113ecbe8c9dfb19d2c297d74a07d67a51dce6861164bf8d1',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0xd219ffe92c72ffc9df877d654aae7f3995e7f6631667756c0b962da70a2ca3d0',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0xb4d37fa68d148ae0ea3d48464415ee6969220de75f11f754aed007cebdec33df',
  ANIMA: '0x82fedbc1262381127844460fd31979841095cb42d0e0c20224f7d41a01c2aff6',
  ACT: '0x82cc70323d49cb574dc8e533024f1aaa76aef768f231e3f08a351c753370450d',
  KIOSK: '0x0717a13f43deaf5345682153e3633f76cdcf695405959697fcd63f63f289320b',
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
