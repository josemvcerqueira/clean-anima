import { Inputs } from '@mysten/sui/transactions';

export const OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0x7c4ac76af6a3e47a5571cc11cba4157eba0024e1bf4d5699577bd23394391e4a',
    initialSharedVersion: '104923326',
    mutable: false,
  }),
  SYSTEM: Inputs.SharedObjectRef({
    objectId:
      '0xbf0cc060b579bc500ff74a9a398db3cb57a0ac2c7cf9ad595d9f74a1bf7a918d',
    mutable: true,
    initialSharedVersion: '104923327',
  }),
  ADMIN: '0x163d03f0d1d88795641a064657b4df1c7348f21f9d66a440be75653d06a18986',
  SUPER_ADMIN:
    '0xa9b0edbd9a8c9bbd18658ee10120bdeb01b8ed9c29bb160779232dfef0cd83f1',
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x01f94bff0b0c77c7746e8a9a3389ee85e374fddd0d966567dda5a2d7e60a1e73',
    mutable: false,
    initialSharedVersion: '104923328',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0xe2758e5463de7f26cb4a3f104ec3b06066f05a0396c9dc2a67772adea524f4ce',
    mutable: false,
    initialSharedVersion: '104923328',
  }),
  AVATAR_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0x17702729c83d3b1a39519fb780553fc3d482548024bb3ad2f2bda89575ecafcc',
    mutable: true,
    initialSharedVersion: '104923328',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0x7b240fdd530652f6e5afe86385db19bc4db599ffcbc947c151f7662301cf2127',
    mutable: true,
    initialSharedVersion: '104923328',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x7eaf3e25e533109e2f9b3e1df298307e748373103ffd9b9cf30187f6db66ff5d',
    mutable: false,
    initialSharedVersion: '104923328',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId: '104923328',
    mutable: false,
    initialSharedVersion:
      '0x2501dfa31ffe13dc163737e2d175351c1d37ad4877349e505d5243ad5c66f5fc',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0xa182134bf688fd46302b522bdee674785cf5d502c4203687ffbc4962908f5284',
    mutable: true,
    initialSharedVersion: '104923328',
  }),
  GENESIS_SHOP_ITEMS_ID:
    '0x9ea56e6433749387aee30bfc210b60c743a907b27386e2ae91a57d7a58adec53',
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0x1a2e47fb234246791d2942a7c330dfae99470581f7b4dcd56886663448949d5e',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0x9bcebcb20a23dfeb86f0f3ff81c54fe147a35207337a2e2cc85d121ed8d9782f',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0xb6ef6ec2708e1cd1a176607dc3ca03a0f1b1a9cbdecf5189a4c25966afdd5811',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0xc50b8834b0adb76bb48bd4839cc52c8c44ef31e404b79a595573b6e6d1a498f7',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0xad1654082fcb7d214be43b51fc00109e91d11af1dc929af5a6cc85c8657e7af4',
  ANIMA: '0x4eaefc88507b0b1c2579704d352f631ac63acc46ad66b7e904b3a7981a2609c6',
  ACT: '0x3885905d83c6507b6f132e0af16e10c406f992865dbe8f46a5f84ae0502bc4a6',
  KIOSK: '0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585',
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
