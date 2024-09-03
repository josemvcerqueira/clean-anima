import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64} from "@mysten/sui/utils";

/* ============================== AVATAR =============================== */

export function isAVATAR(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::AVATAR`; }

export interface AVATARFields { dummyField: ToField<"bool"> }

export type AVATARReified = Reified< AVATAR, AVATARFields >;

export class AVATAR implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::avatar::AVATAR`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = AVATAR.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::avatar::AVATAR`; readonly $typeArgs: []; readonly $isPhantom = AVATAR.$isPhantom;

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: AVATARFields, ) { this.$fullTypeName = composeSuiType( AVATAR.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::AVATAR`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): AVATARReified { return { typeName: AVATAR.$typeName, fullTypeName: composeSuiType( AVATAR.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::AVATAR`, typeArgs: [ ] as [], isPhantom: AVATAR.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AVATAR.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AVATAR.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AVATAR.fromBcs( data, ), bcs: AVATAR.bcs, fromJSONField: (field: any) => AVATAR.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AVATAR.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AVATAR.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => AVATAR.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => AVATAR.fetch( client, id, ), new: ( fields: AVATARFields, ) => { return new AVATAR( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return AVATAR.reified() }

 static phantom( ): PhantomReified<ToTypeStr<AVATAR>> { return phantom(AVATAR.reified( )); } static get p() { return AVATAR.phantom() }

 static get bcs() { return bcs.struct("AVATAR", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): AVATAR { return AVATAR.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): AVATAR { if (!isAVATAR(item.type)) { throw new Error("not a AVATAR type");

 }

 return AVATAR.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): AVATAR { return AVATAR.fromFields( AVATAR.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): AVATAR { return AVATAR.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): AVATAR { if (json.$typeName !== AVATAR.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return AVATAR.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): AVATAR { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAVATAR(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a AVATAR object`); } return AVATAR.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): AVATAR { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAVATAR(data.bcs.type)) { throw new Error(`object at is not a AVATAR object`); }

 return AVATAR.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return AVATAR.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<AVATAR> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AVATAR object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAVATAR(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AVATAR object`); }

 return AVATAR.fromSuiObjectData( res.data ); }

 }

/* ============================== Avatar =============================== */

export function isAvatar(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::Avatar`; }

export interface AvatarFields { id: ToField<UID>; imageUrl: ToField<String>; avatarModel: ToField<String>; avatarTexture: ToField<String>; edition: ToField<String>; attributes: ToField<VecMap<String, String>>; attributesHash: ToField<VecMap<String, Vector<"u8">>>; misc: ToField<VecMap<String, String>> }

export type AvatarReified = Reified< Avatar, AvatarFields >;

export class Avatar implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::avatar::Avatar`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Avatar.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::avatar::Avatar`; readonly $typeArgs: []; readonly $isPhantom = Avatar.$isPhantom;

 readonly id: ToField<UID>; readonly imageUrl: ToField<String>; readonly avatarModel: ToField<String>; readonly avatarTexture: ToField<String>; readonly edition: ToField<String>; readonly attributes: ToField<VecMap<String, String>>; readonly attributesHash: ToField<VecMap<String, Vector<"u8">>>; readonly misc: ToField<VecMap<String, String>>

 private constructor(typeArgs: [], fields: AvatarFields, ) { this.$fullTypeName = composeSuiType( Avatar.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::Avatar`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.imageUrl = fields.imageUrl;; this.avatarModel = fields.avatarModel;; this.avatarTexture = fields.avatarTexture;; this.edition = fields.edition;; this.attributes = fields.attributes;; this.attributesHash = fields.attributesHash;; this.misc = fields.misc; }

 static reified( ): AvatarReified { return { typeName: Avatar.$typeName, fullTypeName: composeSuiType( Avatar.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::Avatar`, typeArgs: [ ] as [], isPhantom: Avatar.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Avatar.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Avatar.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Avatar.fromBcs( data, ), bcs: Avatar.bcs, fromJSONField: (field: any) => Avatar.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Avatar.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Avatar.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Avatar.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Avatar.fetch( client, id, ), new: ( fields: AvatarFields, ) => { return new Avatar( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Avatar.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Avatar>> { return phantom(Avatar.reified( )); } static get p() { return Avatar.phantom() }

 static get bcs() { return bcs.struct("Avatar", {

 id: UID.bcs, image_url: String.bcs, avatar_model: String.bcs, avatar_texture: String.bcs, edition: String.bcs, attributes: VecMap.bcs(String.bcs, String.bcs), attributes_hash: VecMap.bcs(String.bcs, bcs.vector(bcs.u8())), misc: VecMap.bcs(String.bcs, String.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Avatar { return Avatar.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), imageUrl: decodeFromFields(String.reified(), fields.image_url), avatarModel: decodeFromFields(String.reified(), fields.avatar_model), avatarTexture: decodeFromFields(String.reified(), fields.avatar_texture), edition: decodeFromFields(String.reified(), fields.edition), attributes: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.attributes), attributesHash: decodeFromFields(VecMap.reified(String.reified(), reified.vector("u8")), fields.attributes_hash), misc: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.misc) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Avatar { if (!isAvatar(item.type)) { throw new Error("not a Avatar type");

 }

 return Avatar.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), avatarModel: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_model), avatarTexture: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_texture), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), attributes: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.attributes), attributesHash: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), reified.vector("u8")), item.fields.attributes_hash), misc: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.misc) } ) }

 static fromBcs( data: Uint8Array ): Avatar { return Avatar.fromFields( Avatar.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,imageUrl: this.imageUrl,avatarModel: this.avatarModel,avatarTexture: this.avatarTexture,edition: this.edition,attributes: this.attributes.toJSONField(),attributesHash: this.attributesHash.toJSONField(),misc: this.misc.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Avatar { return Avatar.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), avatarModel: decodeFromJSONField(String.reified(), field.avatarModel), avatarTexture: decodeFromJSONField(String.reified(), field.avatarTexture), edition: decodeFromJSONField(String.reified(), field.edition), attributes: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.attributes), attributesHash: decodeFromJSONField(VecMap.reified(String.reified(), reified.vector("u8")), field.attributesHash), misc: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.misc) } ) }

 static fromJSON( json: Record<string, any> ): Avatar { if (json.$typeName !== Avatar.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Avatar.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Avatar { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatar(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Avatar object`); } return Avatar.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Avatar { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAvatar(data.bcs.type)) { throw new Error(`object at is not a Avatar object`); }

 return Avatar.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Avatar.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Avatar> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Avatar object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatar(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Avatar object`); }

 return Avatar.fromSuiObjectData( res.data ); }

 }

/* ============================== AvatarSettings =============================== */

export function isAvatarSettings(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::AvatarSettings`; }

export interface AvatarSettingsFields { id: ToField<UID>; edition: ToField<String>; imageUrl: ToField<String>; avatarModel: ToField<String>; avatarTexture: ToField<String>; active: ToField<"bool"> }

export type AvatarSettingsReified = Reified< AvatarSettings, AvatarSettingsFields >;

export class AvatarSettings implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::avatar::AvatarSettings`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = AvatarSettings.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::avatar::AvatarSettings`; readonly $typeArgs: []; readonly $isPhantom = AvatarSettings.$isPhantom;

 readonly id: ToField<UID>; readonly edition: ToField<String>; readonly imageUrl: ToField<String>; readonly avatarModel: ToField<String>; readonly avatarTexture: ToField<String>; readonly active: ToField<"bool">

 private constructor(typeArgs: [], fields: AvatarSettingsFields, ) { this.$fullTypeName = composeSuiType( AvatarSettings.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::AvatarSettings`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.edition = fields.edition;; this.imageUrl = fields.imageUrl;; this.avatarModel = fields.avatarModel;; this.avatarTexture = fields.avatarTexture;; this.active = fields.active; }

 static reified( ): AvatarSettingsReified { return { typeName: AvatarSettings.$typeName, fullTypeName: composeSuiType( AvatarSettings.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::AvatarSettings`, typeArgs: [ ] as [], isPhantom: AvatarSettings.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AvatarSettings.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AvatarSettings.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AvatarSettings.fromBcs( data, ), bcs: AvatarSettings.bcs, fromJSONField: (field: any) => AvatarSettings.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AvatarSettings.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AvatarSettings.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => AvatarSettings.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => AvatarSettings.fetch( client, id, ), new: ( fields: AvatarSettingsFields, ) => { return new AvatarSettings( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return AvatarSettings.reified() }

 static phantom( ): PhantomReified<ToTypeStr<AvatarSettings>> { return phantom(AvatarSettings.reified( )); } static get p() { return AvatarSettings.phantom() }

 static get bcs() { return bcs.struct("AvatarSettings", {

 id: UID.bcs, edition: String.bcs, image_url: String.bcs, avatar_model: String.bcs, avatar_texture: String.bcs, active: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): AvatarSettings { return AvatarSettings.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), edition: decodeFromFields(String.reified(), fields.edition), imageUrl: decodeFromFields(String.reified(), fields.image_url), avatarModel: decodeFromFields(String.reified(), fields.avatar_model), avatarTexture: decodeFromFields(String.reified(), fields.avatar_texture), active: decodeFromFields("bool", fields.active) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): AvatarSettings { if (!isAvatarSettings(item.type)) { throw new Error("not a AvatarSettings type");

 }

 return AvatarSettings.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), avatarModel: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_model), avatarTexture: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_texture), active: decodeFromFieldsWithTypes("bool", item.fields.active) } ) }

 static fromBcs( data: Uint8Array ): AvatarSettings { return AvatarSettings.fromFields( AvatarSettings.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,edition: this.edition,imageUrl: this.imageUrl,avatarModel: this.avatarModel,avatarTexture: this.avatarTexture,active: this.active,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): AvatarSettings { return AvatarSettings.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), edition: decodeFromJSONField(String.reified(), field.edition), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), avatarModel: decodeFromJSONField(String.reified(), field.avatarModel), avatarTexture: decodeFromJSONField(String.reified(), field.avatarTexture), active: decodeFromJSONField("bool", field.active) } ) }

 static fromJSON( json: Record<string, any> ): AvatarSettings { if (json.$typeName !== AvatarSettings.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return AvatarSettings.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): AvatarSettings { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatarSettings(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a AvatarSettings object`); } return AvatarSettings.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): AvatarSettings { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAvatarSettings(data.bcs.type)) { throw new Error(`object at is not a AvatarSettings object`); }

 return AvatarSettings.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return AvatarSettings.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<AvatarSettings> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AvatarSettings object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatarSettings(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AvatarSettings object`); }

 return AvatarSettings.fromSuiObjectData( res.data ); }

 }

/* ============================== CosmeticKey =============================== */

export function isCosmeticKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::CosmeticKey`; }

export interface CosmeticKeyFields { pos0: ToField<String> }

export type CosmeticKeyReified = Reified< CosmeticKey, CosmeticKeyFields >;

export class CosmeticKey implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::avatar::CosmeticKey`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = CosmeticKey.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::avatar::CosmeticKey`; readonly $typeArgs: []; readonly $isPhantom = CosmeticKey.$isPhantom;

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: CosmeticKeyFields, ) { this.$fullTypeName = composeSuiType( CosmeticKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::CosmeticKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): CosmeticKeyReified { return { typeName: CosmeticKey.$typeName, fullTypeName: composeSuiType( CosmeticKey.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::CosmeticKey`, typeArgs: [ ] as [], isPhantom: CosmeticKey.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => CosmeticKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => CosmeticKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => CosmeticKey.fromBcs( data, ), bcs: CosmeticKey.bcs, fromJSONField: (field: any) => CosmeticKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => CosmeticKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => CosmeticKey.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => CosmeticKey.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => CosmeticKey.fetch( client, id, ), new: ( fields: CosmeticKeyFields, ) => { return new CosmeticKey( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return CosmeticKey.reified() }

 static phantom( ): PhantomReified<ToTypeStr<CosmeticKey>> { return phantom(CosmeticKey.reified( )); } static get p() { return CosmeticKey.phantom() }

 static get bcs() { return bcs.struct("CosmeticKey", {

 pos0: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): CosmeticKey { return CosmeticKey.reified( ).new( { pos0: decodeFromFields(String.reified(), fields.pos0) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): CosmeticKey { if (!isCosmeticKey(item.type)) { throw new Error("not a CosmeticKey type");

 }

 return CosmeticKey.reified( ).new( { pos0: decodeFromFieldsWithTypes(String.reified(), item.fields.pos0) } ) }

 static fromBcs( data: Uint8Array ): CosmeticKey { return CosmeticKey.fromFields( CosmeticKey.bcs.parse(data) ) }

 toJSONField() { return {

 pos0: this.pos0,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): CosmeticKey { return CosmeticKey.reified( ).new( { pos0: decodeFromJSONField(String.reified(), field.pos0) } ) }

 static fromJSON( json: Record<string, any> ): CosmeticKey { if (json.$typeName !== CosmeticKey.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return CosmeticKey.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): CosmeticKey { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCosmeticKey(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a CosmeticKey object`); } return CosmeticKey.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): CosmeticKey { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isCosmeticKey(data.bcs.type)) { throw new Error(`object at is not a CosmeticKey object`); }

 return CosmeticKey.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return CosmeticKey.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<CosmeticKey> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching CosmeticKey object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCosmeticKey(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a CosmeticKey object`); }

 return CosmeticKey.fromSuiObjectData( res.data ); }

 }

/* ============================== WeaponKey =============================== */

export function isWeaponKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::WeaponKey`; }

export interface WeaponKeyFields { pos0: ToField<String> }

export type WeaponKeyReified = Reified< WeaponKey, WeaponKeyFields >;

export class WeaponKey implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::avatar::WeaponKey`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = WeaponKey.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::avatar::WeaponKey`; readonly $typeArgs: []; readonly $isPhantom = WeaponKey.$isPhantom;

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: WeaponKeyFields, ) { this.$fullTypeName = composeSuiType( WeaponKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::WeaponKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): WeaponKeyReified { return { typeName: WeaponKey.$typeName, fullTypeName: composeSuiType( WeaponKey.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::WeaponKey`, typeArgs: [ ] as [], isPhantom: WeaponKey.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => WeaponKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => WeaponKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => WeaponKey.fromBcs( data, ), bcs: WeaponKey.bcs, fromJSONField: (field: any) => WeaponKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => WeaponKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => WeaponKey.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => WeaponKey.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => WeaponKey.fetch( client, id, ), new: ( fields: WeaponKeyFields, ) => { return new WeaponKey( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return WeaponKey.reified() }

 static phantom( ): PhantomReified<ToTypeStr<WeaponKey>> { return phantom(WeaponKey.reified( )); } static get p() { return WeaponKey.phantom() }

 static get bcs() { return bcs.struct("WeaponKey", {

 pos0: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): WeaponKey { return WeaponKey.reified( ).new( { pos0: decodeFromFields(String.reified(), fields.pos0) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): WeaponKey { if (!isWeaponKey(item.type)) { throw new Error("not a WeaponKey type");

 }

 return WeaponKey.reified( ).new( { pos0: decodeFromFieldsWithTypes(String.reified(), item.fields.pos0) } ) }

 static fromBcs( data: Uint8Array ): WeaponKey { return WeaponKey.fromFields( WeaponKey.bcs.parse(data) ) }

 toJSONField() { return {

 pos0: this.pos0,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): WeaponKey { return WeaponKey.reified( ).new( { pos0: decodeFromJSONField(String.reified(), field.pos0) } ) }

 static fromJSON( json: Record<string, any> ): WeaponKey { if (json.$typeName !== WeaponKey.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return WeaponKey.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): WeaponKey { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isWeaponKey(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a WeaponKey object`); } return WeaponKey.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): WeaponKey { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isWeaponKey(data.bcs.type)) { throw new Error(`object at is not a WeaponKey object`); }

 return WeaponKey.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return WeaponKey.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<WeaponKey> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching WeaponKey object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isWeaponKey(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a WeaponKey object`); }

 return WeaponKey.fromSuiObjectData( res.data ); }

 }
