import { Inputs } from '@mysten/sui/transactions';

export const SHARED_OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0x4b762d3b8308277bbb310fa024a59fb77d0373c78186e41f82556891cbe0002f',
    initialSharedVersion: '121402935',
    mutable: false,
  }),
  ACCESS_CONTROL_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x4b762d3b8308277bbb310fa024a59fb77d0373c78186e41f82556891cbe0002f',
    initialSharedVersion: '121402935',
    mutable: true,
  }),
  SYSTEM: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  SYSTEM_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  SALE_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  GENESIS_SHOP_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  AVATAR_SETTINGS: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  AVATAR_SETTINGS_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  PROFILE_PICTURES: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  PROFILE_PICTURES_MUT: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
};

export const OWNED_OBJECTS = {
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP: '',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP: '',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP: '',
  WEAPON_TRANSFER_POLICY_TRADING_CAP: '',
  ADMIN: '0x40aeb73d050107c1980f650a0c8721c69eaa235bf5ab496bddd0aef196f7d3fc',
  SUPER_ADMIN:
    '0x757cbfe28d5d93fdf96816c651cb63359dc2c84f38d3750f36f7bc1d164e1bd1',
  ANIMA_LIB_UPGRADE_CAP:
    '0xcc9413cbb90238289ee4a5043474651510ddecaab36c8821e4e399e15a0806e4',
  ANIMA_UPGRADE_CAP: '',
  GENESIS_SHOP_ITEMS_ID: '',
  DISPLAY_WEAPON: '',
  DISPLAY_AVATAR: '',
  DISPLAY_COSMETIC: '',
  DISPLAY_GENESIS_PASS: '',
  GENESIS_DROP_PUBLISHER: '',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0x28bb1ad72138d9886efb358e746aae38b15adaf74af449a866b65680f17d746b',
  ANIMA: '',
  ACT: '',
  KIOSK: '',
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

export const BUILDER_FN_NAMES = [
  'add_helm',
  'add_upper_torso',
  'add_chestpiece',
  'add_left_arm',
  'add_right_arm',
  'add_left_bracer',
  'add_right_bracer',
  'add_left_glove',
  'add_right_glove',
  'add_left_pauldron',
  'add_right_pauldron',
  'add_legs',
  'add_belt',
  'add_shins',
  'add_boots',
  'add_primary',
  'add_secondary',
  'add_tertiary',
];

export const ROLES = {
  MINTER: [
    71, 69, 78, 69, 83, 73, 83, 95, 77, 73, 78, 84, 69, 82, 95, 82, 79, 76, 69,
  ],
};
