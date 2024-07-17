import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID, UID} from "../../_dependencies/source/0x2/object/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Upgrade} from "../act-upgrade/structs";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== ACT_AVATAR =============================== */

export function isACT_AVATAR(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::ACT_AVATAR`; }

export interface ACT_AVATARFields { dummyField: ToField<"bool"> }

export type ACT_AVATARReified = Reified< ACT_AVATAR, ACT_AVATARFields >;

export class ACT_AVATAR implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::ACT_AVATAR`; static readonly $numTypeParams = 0;

 readonly $typeName = ACT_AVATAR.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::ACT_AVATAR`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: ACT_AVATARFields, ) { this.$fullTypeName = composeSuiType( ACT_AVATAR.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::ACT_AVATAR`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): ACT_AVATARReified { return { typeName: ACT_AVATAR.$typeName, fullTypeName: composeSuiType( ACT_AVATAR.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::ACT_AVATAR`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => ACT_AVATAR.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => ACT_AVATAR.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => ACT_AVATAR.fromBcs( data, ), bcs: ACT_AVATAR.bcs, fromJSONField: (field: any) => ACT_AVATAR.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => ACT_AVATAR.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => ACT_AVATAR.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => ACT_AVATAR.fetch( client, id, ), new: ( fields: ACT_AVATARFields, ) => { return new ACT_AVATAR( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return ACT_AVATAR.reified() }

 static phantom( ): PhantomReified<ToTypeStr<ACT_AVATAR>> { return phantom(ACT_AVATAR.reified( )); } static get p() { return ACT_AVATAR.phantom() }

 static get bcs() { return bcs.struct("ACT_AVATAR", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): ACT_AVATAR { return ACT_AVATAR.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): ACT_AVATAR { if (!isACT_AVATAR(item.type)) { throw new Error("not a ACT_AVATAR type");

 }

 return ACT_AVATAR.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): ACT_AVATAR { return ACT_AVATAR.fromFields( ACT_AVATAR.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): ACT_AVATAR { return ACT_AVATAR.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): ACT_AVATAR { if (json.$typeName !== ACT_AVATAR.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return ACT_AVATAR.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): ACT_AVATAR { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isACT_AVATAR(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a ACT_AVATAR object`); } return ACT_AVATAR.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<ACT_AVATAR> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching ACT_AVATAR object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isACT_AVATAR(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a ACT_AVATAR object`); }
 return ACT_AVATAR.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Accolade =============================== */

export function isAccolade(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::Accolade`; }

export interface AccoladeFields { type: ToField<String>; description: ToField<String>; link: ToField<String> }

export type AccoladeReified = Reified< Accolade, AccoladeFields >;

export class Accolade implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::Accolade`; static readonly $numTypeParams = 0;

 readonly $typeName = Accolade.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::Accolade`;

 readonly $typeArgs: [];

 readonly type: ToField<String>; readonly description: ToField<String>; readonly link: ToField<String>

 private constructor(typeArgs: [], fields: AccoladeFields, ) { this.$fullTypeName = composeSuiType( Accolade.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::Accolade`; this.$typeArgs = typeArgs;

 this.type = fields.type;; this.description = fields.description;; this.link = fields.link; }

 static reified( ): AccoladeReified { return { typeName: Accolade.$typeName, fullTypeName: composeSuiType( Accolade.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::Accolade`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Accolade.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Accolade.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Accolade.fromBcs( data, ), bcs: Accolade.bcs, fromJSONField: (field: any) => Accolade.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Accolade.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Accolade.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Accolade.fetch( client, id, ), new: ( fields: AccoladeFields, ) => { return new Accolade( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Accolade.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Accolade>> { return phantom(Accolade.reified( )); } static get p() { return Accolade.phantom() }

 static get bcs() { return bcs.struct("Accolade", {

 type: String.bcs, description: String.bcs, link: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Accolade { return Accolade.reified( ).new( { type: decodeFromFields(String.reified(), fields.type), description: decodeFromFields(String.reified(), fields.description), link: decodeFromFields(String.reified(), fields.link) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Accolade { if (!isAccolade(item.type)) { throw new Error("not a Accolade type");

 }

 return Accolade.reified( ).new( { type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), description: decodeFromFieldsWithTypes(String.reified(), item.fields.description), link: decodeFromFieldsWithTypes(String.reified(), item.fields.link) } ) }

 static fromBcs( data: Uint8Array ): Accolade { return Accolade.fromFields( Accolade.bcs.parse(data) ) }

 toJSONField() { return {

 type: this.type,description: this.description,link: this.link,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Accolade { return Accolade.reified( ).new( { type: decodeFromJSONField(String.reified(), field.type), description: decodeFromJSONField(String.reified(), field.description), link: decodeFromJSONField(String.reified(), field.link) } ) }

 static fromJSON( json: Record<string, any> ): Accolade { if (json.$typeName !== Accolade.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Accolade.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Accolade { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAccolade(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Accolade object`); } return Accolade.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Accolade> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Accolade object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAccolade(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Accolade object`); }
 return Accolade.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Avatar =============================== */

export function isAvatar(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::Avatar`; }

export interface AvatarFields { id: ToField<UID>; alias: ToField<String>; username: ToField<String>; imageUrl: ToField<String>; imageHash: ToField<String>; modelUrl: ToField<String>; avatarUrl: ToField<String>; avatarHash: ToField<String>; creationDate: ToField<"u64">; edition: ToField<String>; reputation: ToField<Vector<Reputation>>; accolades: ToField<Vector<Accolade>>; upgrades: ToField<Vector<Upgrade>>; attributes: ToField<VecMap<String, String>> }

export type AvatarReified = Reified< Avatar, AvatarFields >;

export class Avatar implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::Avatar`; static readonly $numTypeParams = 0;

 readonly $typeName = Avatar.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::Avatar`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly alias: ToField<String>; readonly username: ToField<String>; readonly imageUrl: ToField<String>; readonly imageHash: ToField<String>; readonly modelUrl: ToField<String>; readonly avatarUrl: ToField<String>; readonly avatarHash: ToField<String>; readonly creationDate: ToField<"u64">; readonly edition: ToField<String>; readonly reputation: ToField<Vector<Reputation>>; readonly accolades: ToField<Vector<Accolade>>; readonly upgrades: ToField<Vector<Upgrade>>; readonly attributes: ToField<VecMap<String, String>>

 private constructor(typeArgs: [], fields: AvatarFields, ) { this.$fullTypeName = composeSuiType( Avatar.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::Avatar`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.alias = fields.alias;; this.username = fields.username;; this.imageUrl = fields.imageUrl;; this.imageHash = fields.imageHash;; this.modelUrl = fields.modelUrl;; this.avatarUrl = fields.avatarUrl;; this.avatarHash = fields.avatarHash;; this.creationDate = fields.creationDate;; this.edition = fields.edition;; this.reputation = fields.reputation;; this.accolades = fields.accolades;; this.upgrades = fields.upgrades;; this.attributes = fields.attributes; }

 static reified( ): AvatarReified { return { typeName: Avatar.$typeName, fullTypeName: composeSuiType( Avatar.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::Avatar`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Avatar.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Avatar.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Avatar.fromBcs( data, ), bcs: Avatar.bcs, fromJSONField: (field: any) => Avatar.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Avatar.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Avatar.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Avatar.fetch( client, id, ), new: ( fields: AvatarFields, ) => { return new Avatar( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Avatar.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Avatar>> { return phantom(Avatar.reified( )); } static get p() { return Avatar.phantom() }

 static get bcs() { return bcs.struct("Avatar", {

 id: UID.bcs, alias: String.bcs, username: String.bcs, image_url: String.bcs, image_hash: String.bcs, model_url: String.bcs, avatar_url: String.bcs, avatar_hash: String.bcs, creation_date: bcs.u64(), edition: String.bcs, reputation: bcs.vector(Reputation.bcs), accolades: bcs.vector(Accolade.bcs), upgrades: bcs.vector(Upgrade.bcs), attributes: VecMap.bcs(String.bcs, String.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Avatar { return Avatar.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), alias: decodeFromFields(String.reified(), fields.alias), username: decodeFromFields(String.reified(), fields.username), imageUrl: decodeFromFields(String.reified(), fields.image_url), imageHash: decodeFromFields(String.reified(), fields.image_hash), modelUrl: decodeFromFields(String.reified(), fields.model_url), avatarUrl: decodeFromFields(String.reified(), fields.avatar_url), avatarHash: decodeFromFields(String.reified(), fields.avatar_hash), creationDate: decodeFromFields("u64", fields.creation_date), edition: decodeFromFields(String.reified(), fields.edition), reputation: decodeFromFields(reified.vector(Reputation.reified()), fields.reputation), accolades: decodeFromFields(reified.vector(Accolade.reified()), fields.accolades), upgrades: decodeFromFields(reified.vector(Upgrade.reified()), fields.upgrades), attributes: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.attributes) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Avatar { if (!isAvatar(item.type)) { throw new Error("not a Avatar type");

 }

 return Avatar.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), alias: decodeFromFieldsWithTypes(String.reified(), item.fields.alias), username: decodeFromFieldsWithTypes(String.reified(), item.fields.username), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), imageHash: decodeFromFieldsWithTypes(String.reified(), item.fields.image_hash), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), avatarUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_url), avatarHash: decodeFromFieldsWithTypes(String.reified(), item.fields.avatar_hash), creationDate: decodeFromFieldsWithTypes("u64", item.fields.creation_date), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), reputation: decodeFromFieldsWithTypes(reified.vector(Reputation.reified()), item.fields.reputation), accolades: decodeFromFieldsWithTypes(reified.vector(Accolade.reified()), item.fields.accolades), upgrades: decodeFromFieldsWithTypes(reified.vector(Upgrade.reified()), item.fields.upgrades), attributes: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.attributes) } ) }

 static fromBcs( data: Uint8Array ): Avatar { return Avatar.fromFields( Avatar.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,alias: this.alias,username: this.username,imageUrl: this.imageUrl,imageHash: this.imageHash,modelUrl: this.modelUrl,avatarUrl: this.avatarUrl,avatarHash: this.avatarHash,creationDate: this.creationDate.toString(),edition: this.edition,reputation: fieldToJSON<Vector<Reputation>>(`vector<${Reputation.$typeName}>`, this.reputation),accolades: fieldToJSON<Vector<Accolade>>(`vector<${Accolade.$typeName}>`, this.accolades),upgrades: fieldToJSON<Vector<Upgrade>>(`vector<${Upgrade.$typeName}>`, this.upgrades),attributes: this.attributes.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Avatar { return Avatar.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), alias: decodeFromJSONField(String.reified(), field.alias), username: decodeFromJSONField(String.reified(), field.username), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), imageHash: decodeFromJSONField(String.reified(), field.imageHash), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), avatarUrl: decodeFromJSONField(String.reified(), field.avatarUrl), avatarHash: decodeFromJSONField(String.reified(), field.avatarHash), creationDate: decodeFromJSONField("u64", field.creationDate), edition: decodeFromJSONField(String.reified(), field.edition), reputation: decodeFromJSONField(reified.vector(Reputation.reified()), field.reputation), accolades: decodeFromJSONField(reified.vector(Accolade.reified()), field.accolades), upgrades: decodeFromJSONField(reified.vector(Upgrade.reified()), field.upgrades), attributes: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.attributes) } ) }

 static fromJSON( json: Record<string, any> ): Avatar { if (json.$typeName !== Avatar.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Avatar.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Avatar { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatar(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Avatar object`); } return Avatar.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Avatar> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Avatar object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatar(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Avatar object`); }
 return Avatar.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== AvatarRegistry =============================== */

export function isAvatarRegistry(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::AvatarRegistry`; }

export interface AvatarRegistryFields { id: ToField<UID>; accounts: ToField<Table<"address", ToPhantom<ID>>> }

export type AvatarRegistryReified = Reified< AvatarRegistry, AvatarRegistryFields >;

export class AvatarRegistry implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::AvatarRegistry`; static readonly $numTypeParams = 0;

 readonly $typeName = AvatarRegistry.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::AvatarRegistry`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly accounts: ToField<Table<"address", ToPhantom<ID>>>

 private constructor(typeArgs: [], fields: AvatarRegistryFields, ) { this.$fullTypeName = composeSuiType( AvatarRegistry.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::AvatarRegistry`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.accounts = fields.accounts; }

 static reified( ): AvatarRegistryReified { return { typeName: AvatarRegistry.$typeName, fullTypeName: composeSuiType( AvatarRegistry.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::AvatarRegistry`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AvatarRegistry.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AvatarRegistry.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AvatarRegistry.fromBcs( data, ), bcs: AvatarRegistry.bcs, fromJSONField: (field: any) => AvatarRegistry.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AvatarRegistry.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AvatarRegistry.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => AvatarRegistry.fetch( client, id, ), new: ( fields: AvatarRegistryFields, ) => { return new AvatarRegistry( [], fields ) }, kind: "StructClassReified", } }

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

export function isCosmeticKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::CosmeticKey`; }

export interface CosmeticKeyFields { pos0: ToField<String> }

export type CosmeticKeyReified = Reified< CosmeticKey, CosmeticKeyFields >;

export class CosmeticKey implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::CosmeticKey`; static readonly $numTypeParams = 0;

 readonly $typeName = CosmeticKey.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::CosmeticKey`;

 readonly $typeArgs: [];

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: CosmeticKeyFields, ) { this.$fullTypeName = composeSuiType( CosmeticKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::CosmeticKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): CosmeticKeyReified { return { typeName: CosmeticKey.$typeName, fullTypeName: composeSuiType( CosmeticKey.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::CosmeticKey`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => CosmeticKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => CosmeticKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => CosmeticKey.fromBcs( data, ), bcs: CosmeticKey.bcs, fromJSONField: (field: any) => CosmeticKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => CosmeticKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => CosmeticKey.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => CosmeticKey.fetch( client, id, ), new: ( fields: CosmeticKeyFields, ) => { return new CosmeticKey( [], fields ) }, kind: "StructClassReified", } }

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

/* ============================== Reputation =============================== */

export function isReputation(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::Reputation`; }

export interface ReputationFields { type: ToField<String>; value: ToField<"u64">; positive: ToField<"bool">; description: ToField<String>; link: ToField<String> }

export type ReputationReified = Reified< Reputation, ReputationFields >;

export class Reputation implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::Reputation`; static readonly $numTypeParams = 0;

 readonly $typeName = Reputation.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::Reputation`;

 readonly $typeArgs: [];

 readonly type: ToField<String>; readonly value: ToField<"u64">; readonly positive: ToField<"bool">; readonly description: ToField<String>; readonly link: ToField<String>

 private constructor(typeArgs: [], fields: ReputationFields, ) { this.$fullTypeName = composeSuiType( Reputation.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::Reputation`; this.$typeArgs = typeArgs;

 this.type = fields.type;; this.value = fields.value;; this.positive = fields.positive;; this.description = fields.description;; this.link = fields.link; }

 static reified( ): ReputationReified { return { typeName: Reputation.$typeName, fullTypeName: composeSuiType( Reputation.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::Reputation`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Reputation.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Reputation.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Reputation.fromBcs( data, ), bcs: Reputation.bcs, fromJSONField: (field: any) => Reputation.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Reputation.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Reputation.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Reputation.fetch( client, id, ), new: ( fields: ReputationFields, ) => { return new Reputation( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Reputation.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Reputation>> { return phantom(Reputation.reified( )); } static get p() { return Reputation.phantom() }

 static get bcs() { return bcs.struct("Reputation", {

 type: String.bcs, value: bcs.u64(), positive: bcs.bool(), description: String.bcs, link: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Reputation { return Reputation.reified( ).new( { type: decodeFromFields(String.reified(), fields.type), value: decodeFromFields("u64", fields.value), positive: decodeFromFields("bool", fields.positive), description: decodeFromFields(String.reified(), fields.description), link: decodeFromFields(String.reified(), fields.link) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Reputation { if (!isReputation(item.type)) { throw new Error("not a Reputation type");

 }

 return Reputation.reified( ).new( { type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), value: decodeFromFieldsWithTypes("u64", item.fields.value), positive: decodeFromFieldsWithTypes("bool", item.fields.positive), description: decodeFromFieldsWithTypes(String.reified(), item.fields.description), link: decodeFromFieldsWithTypes(String.reified(), item.fields.link) } ) }

 static fromBcs( data: Uint8Array ): Reputation { return Reputation.fromFields( Reputation.bcs.parse(data) ) }

 toJSONField() { return {

 type: this.type,value: this.value.toString(),positive: this.positive,description: this.description,link: this.link,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Reputation { return Reputation.reified( ).new( { type: decodeFromJSONField(String.reified(), field.type), value: decodeFromJSONField("u64", field.value), positive: decodeFromJSONField("bool", field.positive), description: decodeFromJSONField(String.reified(), field.description), link: decodeFromJSONField(String.reified(), field.link) } ) }

 static fromJSON( json: Record<string, any> ): Reputation { if (json.$typeName !== Reputation.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Reputation.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Reputation { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isReputation(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Reputation object`); } return Reputation.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Reputation> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Reputation object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isReputation(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Reputation object`); }
 return Reputation.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== WeaponKey =============================== */

export function isWeaponKey(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_avatar::WeaponKey`; }

export interface WeaponKeyFields { pos0: ToField<String> }

export type WeaponKeyReified = Reified< WeaponKey, WeaponKeyFields >;

export class WeaponKey implements StructClass { static readonly $typeName = `${PKG_V1}::act_avatar::WeaponKey`; static readonly $numTypeParams = 0;

 readonly $typeName = WeaponKey.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_avatar::WeaponKey`;

 readonly $typeArgs: [];

 readonly pos0: ToField<String>

 private constructor(typeArgs: [], fields: WeaponKeyFields, ) { this.$fullTypeName = composeSuiType( WeaponKey.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_avatar::WeaponKey`; this.$typeArgs = typeArgs;

 this.pos0 = fields.pos0; }

 static reified( ): WeaponKeyReified { return { typeName: WeaponKey.$typeName, fullTypeName: composeSuiType( WeaponKey.$typeName, ...[] ) as `${typeof PKG_V1}::act_avatar::WeaponKey`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => WeaponKey.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => WeaponKey.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => WeaponKey.fromBcs( data, ), bcs: WeaponKey.bcs, fromJSONField: (field: any) => WeaponKey.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => WeaponKey.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => WeaponKey.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => WeaponKey.fetch( client, id, ), new: ( fields: WeaponKeyFields, ) => { return new WeaponKey( [], fields ) }, kind: "StructClassReified", } }

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
