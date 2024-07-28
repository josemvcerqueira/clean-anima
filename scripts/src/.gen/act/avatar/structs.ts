import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID, UID} from "../../_dependencies/source/0x2/object/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {PKG_V1} from "../index";
import {Upgrade} from "../upgrade/structs";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== AVATAR =============================== */

export function isAVATAR(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::AVATAR`; }

export interface AVATARFields { dummyField: ToField<"bool"> }

export type AVATARReified = Reified< AVATAR, AVATARFields >;

export class AVATAR implements StructClass { static readonly $typeName = `${PKG_V1}::avatar::AVATAR`; static readonly $numTypeParams = 0;

 readonly $typeName = AVATAR.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::avatar::AVATAR`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: AVATARFields, ) { this.$fullTypeName = composeSuiType( AVATAR.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::AVATAR`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): AVATARReified { return { typeName: AVATAR.$typeName, fullTypeName: composeSuiType( AVATAR.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::AVATAR`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AVATAR.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AVATAR.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AVATAR.fromBcs( data, ), bcs: AVATAR.bcs, fromJSONField: (field: any) => AVATAR.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AVATAR.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AVATAR.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => AVATAR.fetch( client, id, ), new: ( fields: AVATARFields, ) => { return new AVATAR( [], fields ) }, kind: "StructClassReified", } }

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

 static async fetch( client: SuiClient, id: string ): Promise<AVATAR> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AVATAR object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAVATAR(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AVATAR object`); }
 return AVATAR.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Avatar =============================== */

export function isAvatar(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::Avatar`; }

export interface AvatarFields { id: ToField<UID>; imageUrl: ToField<String>; imageHash: ToField<String>; modelUrl: ToField<String>; avatarUrl: ToField<String>; avatarHash: ToField<String>; edition: ToField<String>; upgrades: ToField<Vector<Upgrade>>; attributes: ToField<VecMap<String, String>> }

export type AvatarReified = Reified< Avatar, AvatarFields >;

export class Avatar implements StructClass { static readonly $typeName = `${PKG_V1}::avatar::Avatar`; static readonly $numTypeParams = 0;

 readonly $typeName = Avatar.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::avatar::Avatar`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly imageUrl: ToField<String>; readonly imageHash: ToField<String>; readonly modelUrl: ToField<String>; readonly avatarUrl: ToField<String>; readonly avatarHash: ToField<String>; readonly edition: ToField<String>; readonly upgrades: ToField<Vector<Upgrade>>; readonly attributes: ToField<VecMap<String, String>>

 private constructor(typeArgs: [], fields: AvatarFields, ) { this.$fullTypeName = composeSuiType( Avatar.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::Avatar`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.imageUrl = fields.imageUrl;; this.imageHash = fields.imageHash;; this.modelUrl = fields.modelUrl;; this.avatarUrl = fields.avatarUrl;; this.avatarHash = fields.avatarHash;; this.edition = fields.edition;; this.upgrades = fields.upgrades;; this.attributes = fields.attributes; }

 static reified( ): AvatarReified { return { typeName: Avatar.$typeName, fullTypeName: composeSuiType( Avatar.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::Avatar`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Avatar.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Avatar.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Avatar.fromBcs( data, ), bcs: Avatar.bcs, fromJSONField: (field: any) => Avatar.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Avatar.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Avatar.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Avatar.fetch( client, id, ), new: ( fields: AvatarFields, ) => { return new Avatar( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Avatar.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Avatar>> { return phantom(Avatar.reified( )); } static get p() { return Avatar.phantom() }

 static get bcs() { return bcs.struct("Avatar", {

 id: UID.bcs, image_url: String.bcs, image_hash: String.bcs, model_url: String.bcs, avatar_url: String.bcs, avatar_hash: String.bcs, edition: String.bcs, upgrades: bcs.vector(Upgrade.bcs), attributes: VecMap.bcs(String.bcs, String.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Avatar { return Avatar.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), imageUrl: decodeFromFields(String.reified(), fields.image_url), imageHash: decodeFromFields(String.reified(), fields.image_hash), modelUrl: decodeFromFields(String.reified(), fields.model_url), avatarUrl: decodeFromFields(String.reified(), fields.avatar_url), avatarHash: decodeFromFields(String.reified(), fields.avatar_hash), edition: decodeFromFields(String.reified(), fields.edition), upgrades: decodeFromFields(reified.vector(Upgrade.reified()), fields.upgrades), attributes: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.attributes) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Avatar { if (!isAvatar(item.type)) { throw new Error("not a Avatar type");

 }

 return Avatar.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), imageHash: decodeFromFieldsWithTypes(String.reified(), item.fields.image_hash), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), avatarUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_url), avatarHash: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_hash), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), upgrades: decodeFromFieldsWithTypes(reified.vector(Upgrade.reified()), item.fields.upgrades), attributes: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.attributes) } ) }

 static fromBcs( data: Uint8Array ): Avatar { return Avatar.fromFields( Avatar.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,imageUrl: this.imageUrl,imageHash: this.imageHash,modelUrl: this.modelUrl,avatarUrl: this.avatarUrl,avatarHash: this.avatarHash,edition: this.edition,upgrades: fieldToJSON<Vector<Upgrade>>(`vector<${Upgrade.$typeName}>`, this.upgrades),attributes: this.attributes.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Avatar { return Avatar.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), imageHash: decodeFromJSONField(String.reified(), field.imageHash), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), avatarUrl: decodeFromJSONField(String.reified(), field.avatarUrl), avatarHash: decodeFromJSONField(String.reified(), field.avatarHash), edition: decodeFromJSONField(String.reified(), field.edition), upgrades: decodeFromJSONField(reified.vector(Upgrade.reified()), field.upgrades), attributes: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.attributes) } ) }

 static fromJSON( json: Record<string, any> ): Avatar { if (json.$typeName !== Avatar.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Avatar.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Avatar { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatar(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Avatar object`); } return Avatar.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Avatar> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Avatar object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatar(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Avatar object`); }
 return Avatar.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== AvatarRegistry =============================== */

export function isAvatarRegistry(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::AvatarRegistry`; }

export interface AvatarRegistryFields { id: ToField<UID>; accounts: ToField<Table<"address", ToPhantom<ID>>> }

export type AvatarRegistryReified = Reified< AvatarRegistry, AvatarRegistryFields >;

export class AvatarRegistry implements StructClass { static readonly $typeName = `${PKG_V1}::avatar::AvatarRegistry`; static readonly $numTypeParams = 0;

 readonly $typeName = AvatarRegistry.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::avatar::AvatarRegistry`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly accounts: ToField<Table<"address", ToPhantom<ID>>>

 private constructor(typeArgs: [], fields: AvatarRegistryFields, ) { this.$fullTypeName = composeSuiType( AvatarRegistry.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::AvatarRegistry`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.accounts = fields.accounts; }

 static reified( ): AvatarRegistryReified { return { typeName: AvatarRegistry.$typeName, fullTypeName: composeSuiType( AvatarRegistry.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::AvatarRegistry`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AvatarRegistry.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AvatarRegistry.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AvatarRegistry.fromBcs( data, ), bcs: AvatarRegistry.bcs, fromJSONField: (field: any) => AvatarRegistry.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AvatarRegistry.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AvatarRegistry.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => AvatarRegistry.fetch( client, id, ), new: ( fields: AvatarRegistryFields, ) => { return new AvatarRegistry( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return AvatarRegistry.reified() }

 static phantom( ): PhantomReified<ToTypeStr<AvatarRegistry>> { return phantom(AvatarRegistry.reified( )); } static get p() { return AvatarRegistry.phantom() }

 static get bcs() { return bcs.struct("AvatarRegistry", {

 id: UID.bcs, accounts: Table.bcs

}) };

 static fromFields( fields: Record<string, any> ): AvatarRegistry { return AvatarRegistry.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), accounts: decodeFromFields(Table.reified(reified.phantom("address"), reified.phantom(ID.reified())), fields.accounts) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): AvatarRegistry { if (!isAvatarRegistry(item.type)) { throw new Error("not a AvatarRegistry type");

 }

 return AvatarRegistry.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), accounts: decodeFromFieldsWithTypes(Table.reified(reified.phantom("address"), reified.phantom(ID.reified())), item.fields.accounts) } ) }

 static fromBcs( data: Uint8Array ): AvatarRegistry { return AvatarRegistry.fromFields( AvatarRegistry.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,accounts: this.accounts.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): AvatarRegistry { return AvatarRegistry.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), accounts: decodeFromJSONField(Table.reified(reified.phantom("address"), reified.phantom(ID.reified())), field.accounts) } ) }

 static fromJSON( json: Record<string, any> ): AvatarRegistry { if (json.$typeName !== AvatarRegistry.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return AvatarRegistry.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): AvatarRegistry { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatarRegistry(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a AvatarRegistry object`); } return AvatarRegistry.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<AvatarRegistry> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AvatarRegistry object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatarRegistry(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AvatarRegistry object`); }
 return AvatarRegistry.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== CosmeticKey =============================== */

export function isCosmeticKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::CosmeticKey`; }

export interface CosmeticKeyFields { pos0: ToField<String> }

export type CosmeticKeyReified = Reified< CosmeticKey, CosmeticKeyFields >;

export class CosmeticKey implements StructClass { static readonly $typeName = `${PKG_V1}::avatar::CosmeticKey`; static readonly $numTypeParams = 0;

 readonly $typeName = CosmeticKey.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::avatar::CosmeticKey`;

 readonly $typeArgs: [];

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: CosmeticKeyFields, ) { this.$fullTypeName = composeSuiType( CosmeticKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::CosmeticKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): CosmeticKeyReified { return { typeName: CosmeticKey.$typeName, fullTypeName: composeSuiType( CosmeticKey.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::CosmeticKey`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => CosmeticKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => CosmeticKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => CosmeticKey.fromBcs( data, ), bcs: CosmeticKey.bcs, fromJSONField: (field: any) => CosmeticKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => CosmeticKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => CosmeticKey.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => CosmeticKey.fetch( client, id, ), new: ( fields: CosmeticKeyFields, ) => { return new CosmeticKey( [], fields ) }, kind: "StructClassReified", } }

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

 static async fetch( client: SuiClient, id: string ): Promise<CosmeticKey> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching CosmeticKey object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCosmeticKey(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a CosmeticKey object`); }
 return CosmeticKey.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== WeaponKey =============================== */

export function isWeaponKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::avatar::WeaponKey`; }

export interface WeaponKeyFields { pos0: ToField<String> }

export type WeaponKeyReified = Reified< WeaponKey, WeaponKeyFields >;

export class WeaponKey implements StructClass { static readonly $typeName = `${PKG_V1}::avatar::WeaponKey`; static readonly $numTypeParams = 0;

 readonly $typeName = WeaponKey.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::avatar::WeaponKey`;

 readonly $typeArgs: [];

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: WeaponKeyFields, ) { this.$fullTypeName = composeSuiType( WeaponKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::avatar::WeaponKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): WeaponKeyReified { return { typeName: WeaponKey.$typeName, fullTypeName: composeSuiType( WeaponKey.$typeName, ...[] ) as `${typeof PKG_V1}::avatar::WeaponKey`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => WeaponKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => WeaponKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => WeaponKey.fromBcs( data, ), bcs: WeaponKey.bcs, fromJSONField: (field: any) => WeaponKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => WeaponKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => WeaponKey.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => WeaponKey.fetch( client, id, ), new: ( fields: WeaponKeyFields, ) => { return new WeaponKey( [], fields ) }, kind: "StructClassReified", } }

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

 static async fetch( client: SuiClient, id: string ): Promise<WeaponKey> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching WeaponKey object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isWeaponKey(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a WeaponKey object`); }
 return WeaponKey.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
