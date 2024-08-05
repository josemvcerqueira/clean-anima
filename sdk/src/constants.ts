import { Inputs } from '@mysten/sui/transactions';

export const OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId:
      '0xaef4d35758d7457458ae675f58e7f513dece72083b725d65385346d945e90fd5',
    initialSharedVersion: '89890914',
    mutable: false,
  }),
  ACCOUNT_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0x9ae75b84f864c07086cc2b10ab6a00d35785e02928fbcee1330ba505bb53fce0',
    mutable: true,
    initialSharedVersion: '89890915',
  }),
  SUPER_ADMIN:
    '0x803b9ed9752e4cb2a70067f453f0591761135712371c92325ead443f3be73e84',
  ADMIN: '0xb6a8b665f8c8b949f01e8a88d9171af5ac4f98dd7d32295432e2f5a774b0af50',
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0x48341fe7f16aaffc1559d42c4cb660c1142268a256f655f837dcedcaa1a2cb3c',
    mutable: false,
    initialSharedVersion: '89890916',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x207355d8256a8f836798138e0f11d620c01270e6475e05f8a4f1e57b1751f8d9',
    mutable: false,
    initialSharedVersion: '89890916',
  }),
  AVATAR_REGISTRY: Inputs.SharedObjectRef({
    objectId:
      '0x4cfbaad02a8447a828232ee15c16722af55ec62ad9b6a8ca2060b23ffb9920cb',
    mutable: true,
    initialSharedVersion: '89890916',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId:
      '0x5d72f4c9a567f5461147d0837fb8b3f231a43c14e1dc597ff18f5a404f3709b4',
    mutable: true,
    initialSharedVersion: '89890916',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId:
      '0xbb28109765c3a3b4ab9634c134723fcdeefa59e7c8febf7c546ddfafb2812316',
    mutable: false,
    initialSharedVersion: '89890916',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId:
      '0x7d502c8262857d890200aa02e8bc506b4e8f6bdc6144074bab03901baa737040',
    mutable: false,
    initialSharedVersion: '89890916',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId:
      '0x15fea2215837ba8e07fd74337b1cb9e932f62b8b3a8dc1eb0a3c1dc80d6ffc95',
    mutable: true,
    initialSharedVersion: '89890916',
  }),
  GENESIS_SHOP_ITEMS_ID:
    '0x69aaebac7c8cb4ab2973a0d0f20e5d789f0f30a709ddd6bfd66a7c379ddd1d00',
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP:
    '0x96bbc3e7a25c08f4733914a56c6e01cd562a9060fca2d8610271327506ed7ff2',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP:
    '0xbaf84a002274dc0914de45ba64f3a6562ec8004ee689c7ad5e7dd5989fed2c7d',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP:
    '0xcfab7a7a4ee319cd64a2f39a940d1f1311ec520e3f7238bcb0aa9fe01e0c716c',
  WEAPON_TRANSFER_POLICY_TRADING_CAP:
    '0x39303568e9dc792fed05102c3639d8aaf5db162cbb3cd460ffc03521e72db0f5',
};

export const PACKAGES = {
  ANIMA_LIB:
    '0xec2a7e41756d88a0418bb8868e1d85a4177dc2441f4ae0c6716f24683d2b16e2',
  ANIMA: '0xa83e04da932eb54055f40d95a453c4fb482f261e20c462f8929f9a0d9f425f03',
  ACT: '0x09d3b7549e0eb06a034b196f57a60fd20e9303091872d77f03230a434c53359f',
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
