import { Inputs } from '@mysten/sui/transactions';

export const SHARED_OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0x3e9365ba8dd095e7bc3bd382bd33d0ba2278b89bea26aefa4be5bbe6880024cc',
    initialSharedVersion: '111160773',
    mutable: false,
  }),
  ACCESS_CONTROL_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x3e9365ba8dd095e7bc3bd382bd33d0ba2278b89bea26aefa4be5bbe6880024cc',
    initialSharedVersion: '111160773',
    mutable: true,
  }),
  SYSTEM: Inputs.SharedObjectRef({
    objectId:
      '0x3251ca6fde7b5c1178e7a2536b884cf6c210a2448cf05ed22ebdc708afab7a5f',
    mutable: false,
    initialSharedVersion: '111160774',
  }),
  SYSTEM_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x3251ca6fde7b5c1178e7a2536b884cf6c210a2448cf05ed22ebdc708afab7a5f',
    mutable: true,
    initialSharedVersion: '111160774',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '111160775',
    mutable: false,
    initialSharedVersion:
      '0x21bfa13a7152234178e32e27a47a86e92edefcce06818af908143dec10a99343',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId: '111160775',
    mutable: true,
    initialSharedVersion:
      '0x21bfa13a7152234178e32e27a47a86e92edefcce06818af908143dec10a99343',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x53dea1e5f2dd358fb7547f44060631583984e1724157779899e3bd604ad53899',
    mutable: false,
    initialSharedVersion: '111160775',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x53dea1e5f2dd358fb7547f44060631583984e1724157779899e3bd604ad53899',
    mutable: true,
    initialSharedVersion: '111160775',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0xf0bd997a605a337d059d0c9bae619e73509bf9b4792b068681e2909176740e5c',
    mutable: false,
    initialSharedVersion: '111160775',
  }),
  SALE_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xf0bd997a605a337d059d0c9bae619e73509bf9b4792b068681e2909176740e5c',
    mutable: true,
    initialSharedVersion: '111160775',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '111160775',
    mutable: false,
    initialSharedVersion:
      '0x3b01ed3aa4fdb6b7777c336c947d7ca4d2251b12246b96525fe14bca466b15f5',
  }),
  WEAPON_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId: '111160775',
    mutable: true,
    initialSharedVersion:
      '0x3b01ed3aa4fdb6b7777c336c947d7ca4d2251b12246b96525fe14bca466b15f5',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x41e371c7544ff6228adbcf970a63852333b67e32450411d586a19b77e85761fb',
    mutable: false,
    initialSharedVersion: '111160775',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x41e371c7544ff6228adbcf970a63852333b67e32450411d586a19b77e85761fb',
    mutable: true,
    initialSharedVersion: '111160775',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0x9648141334cd1c5d4077fca7ded88eff01b6fd5366297925027cd4ac67c50ea1',
    mutable: false,
    initialSharedVersion: '111160775',
  }),
  GENESIS_SHOP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x9648141334cd1c5d4077fca7ded88eff01b6fd5366297925027cd4ac67c50ea1',
    mutable: true,
    initialSharedVersion: '111160775',
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
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0xae67e1c23fc4569f5ff7cbd32438788927021189ea3123367968c9c1ef893c68',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0x213551317aa96244e563936bc06fd2c295178af5f97bc30a6b258c4f222ffa42',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0x222e8107aa9c2de572c031b2611af7abf1cb1ae4ae3b88bf35132d25df1e6111',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0x0b1ac88c0819ec1d2d19b77aed582ef8f1fb5bf219f6a8dea47ef4efc6fc4978',
  ADMIN: '0x69166ffa3f153642b70a874c37ea457db78f2c6b4e5613d4ea34078c77776065',
  SUPER_ADMIN:
    '0x980599a390271777807fb9cc9d25fe4c7800ce92f0f1a6c5bfa1ec0f3d382b32',
  ANIMA_LIB_UPGRADE_CAP:
    '0x890f8feae56f1943b171b79596da90b225869be464aa3aa1038c3342ea995236',
  ANIMA_UPGRADE_CAP:
    '0x80c50bd115199dbe5ec3514da09c53cc9d14f6fa97857b038f7fa052614f4653',
  GENESIS_SHOP_ITEMS_ID:
    '0xfca41a20ef53616a930c67f06a7e92317489e7653eb46bd046d356db2dd7fd5a',
  DISPLAY_WEAPON:
    '0x5e1326fd7ad245e09e910d0b135005b2dab5f7828703b071b6e57ee46090313b',
  DISPLAY_AVATAR:
    '0xecda70f379aa35f1486108dacab1088e79186a888047edf66dbbd530fb07cc88',
  DISPLAY_COSMETIC:
    '0x42445c5e0a4e3ee6deb3ae76c9984f3a46bd831dd9f18c6aa8ff1f1f752e9602',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0xbccf5774041fd8a3dc5f247c482aed6a40a391070c41f08d65a9bc68f8e1ccbc',
  ANIMA: '0x79e474a77c5ebefa5dad1b20f998c65f4477f69e69a4df23cd058beb5bb8d737',
  ACT: '0xcdb5484020cbb427acbff7b3365ffed5670ffcc5b6fed98f9c94107315c89dda',
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
