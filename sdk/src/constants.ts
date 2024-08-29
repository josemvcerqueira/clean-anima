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
      '0xfa97b5b79d2e55a96d6909e356e5c3374ba7ae4b4a8dae69d858fc425887c1ff',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  COSMETIC_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xfa97b5b79d2e55a96d6909e356e5c3374ba7ae4b4a8dae69d858fc425887c1ff',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x9b1c0908f1999a31ef8da2811a2c5ab320d9295774cd7d2b4e31a526640e2de8',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x9b1c0908f1999a31ef8da2811a2c5ab320d9295774cd7d2b4e31a526640e2de8',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0x52b120434472e5743a6483b99662139cbf93391de484c0c548e39cdac43b131b',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  SALE_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x52b120434472e5743a6483b99662139cbf93391de484c0c548e39cdac43b131b',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0xdefcaa2b077a49d3e4b4977047bd92972221cd8fa5cdfd5868d7bc7b2baefc44',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  WEAPON_TRANSFER_POLICY_TRADING_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xdefcaa2b077a49d3e4b4977047bd92972221cd8fa5cdfd5868d7bc7b2baefc44',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0xd923d2c9e538e6ba95c45233a8a186023caac68dab90d677a83bf25b3138212f',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xd923d2c9e538e6ba95c45233a8a186023caac68dab90d677a83bf25b3138212f',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0x6561a4653a779401bd07010a505b257a3ca4dbcdf01bb60e13de459978801be6',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  GENESIS_SHOP_MUT: Inputs.SharedObjectRef({
    objectId:
      '0x6561a4653a779401bd07010a505b257a3ca4dbcdf01bb60e13de459978801be6',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  AVATAR_SETTINGS: Inputs.SharedObjectRef({
    objectId:
      '0xe758c19d71844fe9fc1f8845d2137db5ad8d9aa09bd85cabce0261575ba76149',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  AVATAR_SETTINGS_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xe758c19d71844fe9fc1f8845d2137db5ad8d9aa09bd85cabce0261575ba76149',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
  PROFILE_PICTURES: Inputs.SharedObjectRef({
    objectId:
      '0xd9fd258e1a16c83b6788a26665c481b9746e50b371e0db4073425054b2f92c95',
    mutable: false,
    initialSharedVersion: '121403273',
  }),
  PROFILE_PICTURES_MUT: Inputs.SharedObjectRef({
    objectId:
      '0xd9fd258e1a16c83b6788a26665c481b9746e50b371e0db4073425054b2f92c95',
    mutable: true,
    initialSharedVersion: '121403273',
  }),
};

export const OWNED_OBJECTS = {
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0xdf1ba1033a07ead93a4119052296444fcdae71d85f024b0f1060ffd92c673580',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0xfdc653979532e6d99fc0b391f6577f83c216d4be0825c83a99437bc4c268dd05',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0x88fba956e9d51c16aae766b0c738780a04a93eeefc6cef96079e6ca4253ded77',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0x645fb396255abc4d483059b733958acce8e986f472c5bc17b8b5f983e58c78c0',
  WEAPON_PUBLISHER:
    '0x381e7ac078b4b22828fdb686fe805a63dd68ad7fc5b7745884550c093d126fc3',
  GENESIS_DROP_PUBLISHER:
    '0x9cbed69c883df56a6f443b68c771bd5075ea668b673333374aebac336af1288c',
  AVATAR_PUBLISHER:
    '0x60e80e32a7c37e77cf83c7badbeb6219369d614361413a3910a602fc21d63d21',
  COSMETIC_PUBLISHER:
    '0x11e3a7af807a870a67845ab1e13eb3e69dd1d6401ac189081d11390a1b4710be',
  SUPER_ADMIN:
    '0x40aeb73d050107c1980f650a0c8721c69eaa235bf5ab496bddd0aef196f7d3fc',
  ADMIN: '0x757cbfe28d5d93fdf96816c651cb63359dc2c84f38d3750f36f7bc1d164e1bd1',
  ANIMA_LIB_UPGRADE_CAP:
    '0xcc9413cbb90238289ee4a5043474651510ddecaab36c8821e4e399e15a0806e4',
  ANIMA_UPGRADE_CAP:
    '0xbbba69f9552bef08ec671cb49d4b14edb8d177194a04e9d13028d8c6ce08c677',
  ACT_UPGRADE_CAP:
    '0x4136c7f14cf20e34500505d37cd8c18b87095b840b4825f46d5feacbe31d7836',
  GENESIS_SHOP_ITEMS_ID:
    '0xe32e97a76da9421550b7ac947a2392666e60683f880e0b643d91b3f2808cfff3',
  DISPLAY_WEAPON:
    '0x3a88df8f96e4e3f34fee48fdf101c2eda1ceb6678ef9c1c6a89aaab187128871',
  DISPLAY_AVATAR:
    '0xbe8201490e578b5f5e8977378d49d681b7d294f28226e43279a574d1c0959ca1',
  DISPLAY_COSMETIC:
    '0xf29f1fb8ac47b0dade280149080ebdae214ac8906740f794a365e937eeb54122',
  DISPLAY_GENESIS_PASS:
    '0xbca39f3f5a4cd3b94fa7f0d8da935509bd56983593e8e4df8843da594dfeb10f',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0x28bb1ad72138d9886efb358e746aae38b15adaf74af449a866b65680f17d746b',
  ANIMA: '0x1888fbf408a5c30f279c499f4f6c7bac78367e198fbcfdee75b36181f11ee557',
  ACT: '0x0a12940821e0969fa25a2a45fa6e3c1d31d472c75235868903c4f6acc9c36aad',
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
