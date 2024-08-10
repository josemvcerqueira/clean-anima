import { Inputs } from '@mysten/sui/transactions';

export const OBJECTS = {
  ACCESS_CONTROL: Inputs.SharedObjectRef({
    objectId: '',
    initialSharedVersion: '',
    mutable: false,
  }),
  SYSTEM: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  ADMIN: '',
  SUPER_ADMIN: '',
  COSMETIC_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  COSMETIC_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  AVATAR_REGISTRY: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  SALE: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_TRADING: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  WEAPON_TRANSFER_POLICY_EQUIP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: false,
    initialSharedVersion: '',
  }),
  GENESIS_SHOP: Inputs.SharedObjectRef({
    objectId: '',
    mutable: true,
    initialSharedVersion: '',
  }),
  GENESIS_SHOP_ITEMS_ID: '',
  COSMETIC_TRANSFER_POLICY_EQUIP_CAP: '',
  COSMETIC_TRANSFER_POLICY_TRADING_CAP: '',
  WEAPON_TRANSFER_POLICY_EQUIP_CAP: '',
  WEAPON_TRANSFER_POLICY_TRADING_CAP: '',
};

export const PACKAGES = {
  ANIMA_LIB: '',
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
