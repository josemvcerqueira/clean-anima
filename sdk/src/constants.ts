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
    objectId:
      '0x9c24fcc14d64070a887781c2f56b72b14c2d932e9b04691c7d018e24ef67712f',
    mutable: false,
    initialSharedVersion: '121402936',
  }),
  SYSTEM_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x9c24fcc14d64070a887781c2f56b72b14c2d932e9b04691c7d018e24ef67712f',
    mutable: true,
    initialSharedVersion: '121402936',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x09737537f97d5f01a3275642ffdfe319cfba51eaacbc97281e269a99f41b8036',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x09737537f97d5f01a3275642ffdfe319cfba51eaacbc97281e269a99f41b8036',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x8863505994f79565925586ba88cd0afba850b442c91935cc23e8567ed38da00e',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x8863505994f79565925586ba88cd0afba850b442c91935cc23e8567ed38da00e',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0xbfdef09e08cc406a2a182d182307cef12159bb4e6eb59660e030912d13b8b02b',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  SALE_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xbfdef09e08cc406a2a182d182307cef12159bb4e6eb59660e030912d13b8b02b',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x9ad58c0e4c605dc0e5aa0c95230c70f54aec401435240c0757bedd003744273a',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  WEAPON_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x9ad58c0e4c605dc0e5aa0c95230c70f54aec401435240c0757bedd003744273a',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x460dce33752c7b95a643fbe81bf1f557ae2c3a8e13867ad112f32268f02c6b42',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x460dce33752c7b95a643fbe81bf1f557ae2c3a8e13867ad112f32268f02c6b42',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0x5bbc493b920df252034be92bee8e0d06ef88babe3572e0b0e58a5adb03e2f650',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  GENESIS_SHOP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x5bbc493b920df252034be92bee8e0d06ef88babe3572e0b0e58a5adb03e2f650',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  AVATAR_SETTINGS: Inputs.SharedObjectRef({
    objectId:
      '0xe786aa65e58685d558718f0e79e38bf0c04209714ba3dce2bfbbce508a1315a2',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  AVATAR_SETTINGS_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xe786aa65e58685d558718f0e79e38bf0c04209714ba3dce2bfbbce508a1315a2',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
  PROFILE_PICTURES: Inputs.SharedObjectRef({
    objectId:
      '0x46cf9f84630c70e1a38f1224e5e7076d8dd48e23562c398538d30fff731eb539',
    mutable: false,
    initialSharedVersion: '121402937',
  }),
  PROFILE_PICTURES_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x46cf9f84630c70e1a38f1224e5e7076d8dd48e23562c398538d30fff731eb539',
    mutable: true,
    initialSharedVersion: '121402937',
  }),
};

export const OWNED_OBJECTS = {
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0x805c7b4da6df1b021bb0f0a2d0ed8b5030b597bb5b6bc2cca75ce25264e401b7',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0x01104077e9dd190a6b842750a30402ad09ee2b530de1a6774f8a980f1dda72cf',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0xc53278d341e01b2655e3321a2011a2c406852d2720d53d0c22ce84f034b5c5e3',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0x8bfe1cd4c19258b10a650f227d8bab3603921dd1852104a5b8f5da3f7c641480',
  WEAPON_PUBLISHER:
    '0x2993812186c9b093966f93fe38953f151aeb5b6891dc293a2ad5816f2f73a952',
  GENESIS_DROP_PUBLISHER:
    '0x3ba875e99f3e10182f8c46bfb0ca9abe0df9f250dc46743b0b0bddf353b54163',
  AVATAR_PUBLISHER:
    '0x53c3b875f16e43923c85dba561b69995e987792135498fc04f6237ba043ed950',
  COSMETIC_PUBLISHER:
    '0xe7dfcf62d7a704b07fd663ecf06cdd9dffdcc151ba089b19673f790bc39bbf52',
  ADMIN: '0x40aeb73d050107c1980f650a0c8721c69eaa235bf5ab496bddd0aef196f7d3fc',
  SUPER_ADMIN:
    '0x757cbfe28d5d93fdf96816c651cb63359dc2c84f38d3750f36f7bc1d164e1bd1',
  ANIMA_LIB_UPGRADE_CAP:
    '0xcc9413cbb90238289ee4a5043474651510ddecaab36c8821e4e399e15a0806e4',
  ANIMA_UPGRADE_CAP:
    '0xbbba69f9552bef08ec671cb49d4b14edb8d177194a04e9d13028d8c6ce08c677',
  ACT_UPGRADE_CAP:
    '0xc248f1ae7f448caf02acb656b6b06f9bcef7f22c86bafdd5ff3e4a4b0429c511',
  GENESIS_SHOP_ITEMS_ID: '',
  DISPLAY_WEAPON:
    '0xba1ba5dab7538f51a57cc1c96ffdf6937daef9cd2c27bd77fc89c6ce365286e7',
  DISPLAY_AVATAR:
    '0x108da4a45c71cce8d60b2ee6ab101f6f13da910cfa1b437f9da7cf18fc53c84d',
  DISPLAY_COSMETIC:
    '0x1ed35441e10983de892f040fa0f4bcd6393e80fab00c0fbeb6ffb6cd63b5d8e0',
  DISPLAY_GENESIS_PASS:
    '0x2112846ff364e0de7ca09c28be804896d8a11f6744ea0d1356889a6029ebb3b3',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0x28bb1ad72138d9886efb358e746aae38b15adaf74af449a866b65680f17d746b',
  ANIMA: '0x1888fbf408a5c30f279c499f4f6c7bac78367e198fbcfdee75b36181f11ee557',
  ACT: '0x885e94dcd839400e281268fc1f997e59e911d77fb7739809d0ca44cc017fad29',
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
