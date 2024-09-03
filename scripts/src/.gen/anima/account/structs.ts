import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {TableVec} from "../../_dependencies/source/0x2/table-vec/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64, fromHEX, toHEX} from "@mysten/sui/utils";

/* ============================== Accolade =============================== */

export function isAccolade(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::account::Accolade`; }

export interface AccoladeFields { type: ToField<String>; description: ToField<String>; url: ToField<String> }

export type AccoladeReified = Reified< Accolade, AccoladeFields >;

export class Accolade implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::account::Accolade`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Accolade.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::account::Accolade`; readonly $typeArgs: []; readonly $isPhantom = Accolade.$isPhantom;

 readonly type: ToField<String>; readonly description: ToField<String>; readonly url: ToField<String>

 private constructor(typeArgs: [], fields: AccoladeFields, ) { this.$fullTypeName = composeSuiType( Accolade.$typeName, ...typeArgs ) as `${typeof PKG_V1}::account::Accolade`; this.$typeArgs = typeArgs;

 this.type = fields.type;; this.description = fields.description;; this.url = fields.url; }

 static reified( ): AccoladeReified { return { typeName: Accolade.$typeName, fullTypeName: composeSuiType( Accolade.$typeName, ...[] ) as `${typeof PKG_V1}::account::Accolade`, typeArgs: [ ] as [], isPhantom: Accolade.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Accolade.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Accolade.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Accolade.fromBcs( data, ), bcs: Accolade.bcs, fromJSONField: (field: any) => Accolade.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Accolade.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Accolade.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Accolade.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Accolade.fetch( client, id, ), new: ( fields: AccoladeFields, ) => { return new Accolade( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Accolade.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Accolade>> { return phantom(Accolade.reified( )); } static get p() { return Accolade.phantom() }

 static get bcs() { return bcs.struct("Accolade", {

 type: String.bcs, description: String.bcs, url: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Accolade { return Accolade.reified( ).new( { type: decodeFromFields(String.reified(), fields.type), description: decodeFromFields(String.reified(), fields.description), url: decodeFromFields(String.reified(), fields.url) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Accolade { if (!isAccolade(item.type)) { throw new Error("not a Accolade type");

 }

 return Accolade.reified( ).new( { type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), description: decodeFromFieldsWithTypes(String.reified(), item.fields.description), url: decodeFromFieldsWithTypes(String.reified(), item.fields.url) } ) }

 static fromBcs( data: Uint8Array ): Accolade { return Accolade.fromFields( Accolade.bcs.parse(data) ) }

 toJSONField() { return {

 type: this.type,description: this.description,url: this.url,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Accolade { return Accolade.reified( ).new( { type: decodeFromJSONField(String.reified(), field.type), description: decodeFromJSONField(String.reified(), field.description), url: decodeFromJSONField(String.reified(), field.url) } ) }

 static fromJSON( json: Record<string, any> ): Accolade { if (json.$typeName !== Accolade.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Accolade.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Accolade { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAccolade(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Accolade object`); } return Accolade.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Accolade { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAccolade(data.bcs.type)) { throw new Error(`object at is not a Accolade object`); }

 return Accolade.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Accolade.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Accolade> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Accolade object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAccolade(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Accolade object`); }

 return Accolade.fromSuiObjectData( res.data ); }

 }

/* ============================== Account =============================== */

export function isAccount(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::account::Account`; }

export interface AccountFields { id: ToField<UID>; alias: ToField<String>; username: ToField<String>; creationDate: ToField<"u64"> }

export type AccountReified = Reified< Account, AccountFields >;

export class Account implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::account::Account`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Account.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::account::Account`; readonly $typeArgs: []; readonly $isPhantom = Account.$isPhantom;

 readonly id: ToField<UID>; readonly alias: ToField<String>; readonly username: ToField<String>; readonly creationDate: ToField<"u64">

 private constructor(typeArgs: [], fields: AccountFields, ) { this.$fullTypeName = composeSuiType( Account.$typeName, ...typeArgs ) as `${typeof PKG_V1}::account::Account`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.alias = fields.alias;; this.username = fields.username;; this.creationDate = fields.creationDate; }

 static reified( ): AccountReified { return { typeName: Account.$typeName, fullTypeName: composeSuiType( Account.$typeName, ...[] ) as `${typeof PKG_V1}::account::Account`, typeArgs: [ ] as [], isPhantom: Account.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Account.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Account.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Account.fromBcs( data, ), bcs: Account.bcs, fromJSONField: (field: any) => Account.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Account.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Account.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Account.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Account.fetch( client, id, ), new: ( fields: AccountFields, ) => { return new Account( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Account.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Account>> { return phantom(Account.reified( )); } static get p() { return Account.phantom() }

 static get bcs() { return bcs.struct("Account", {

 id: UID.bcs, alias: String.bcs, username: String.bcs, creation_date: bcs.u64()

}) };

 static fromFields( fields: Record<string, any> ): Account { return Account.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), alias: decodeFromFields(String.reified(), fields.alias), username: decodeFromFields(String.reified(), fields.username), creationDate: decodeFromFields("u64", fields.creation_date) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Account { if (!isAccount(item.type)) { throw new Error("not a Account type");

 }

 return Account.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), alias: decodeFromFieldsWithTypes(String.reified(), item.fields.alias), username: decodeFromFieldsWithTypes(String.reified(), item.fields.username), creationDate: decodeFromFieldsWithTypes("u64", item.fields.creation_date) } ) }

 static fromBcs( data: Uint8Array ): Account { return Account.fromFields( Account.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,alias: this.alias,username: this.username,creationDate: this.creationDate.toString(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Account { return Account.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), alias: decodeFromJSONField(String.reified(), field.alias), username: decodeFromJSONField(String.reified(), field.username), creationDate: decodeFromJSONField("u64", field.creationDate) } ) }

 static fromJSON( json: Record<string, any> ): Account { if (json.$typeName !== Account.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Account.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Account { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAccount(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Account object`); } return Account.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Account { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAccount(data.bcs.type)) { throw new Error(`object at is not a Account object`); }

 return Account.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Account.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Account> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Account object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAccount(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Account object`); }

 return Account.fromSuiObjectData( res.data ); }

 }

/* ============================== Reputation =============================== */

export function isReputation(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::account::Reputation`; }

export interface ReputationFields { type: ToField<String>; value: ToField<"u64">; positive: ToField<"bool">; description: ToField<String>; url: ToField<String>; issuer: ToField<"address"> }

export type ReputationReified = Reified< Reputation, ReputationFields >;

export class Reputation implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::account::Reputation`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Reputation.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::account::Reputation`; readonly $typeArgs: []; readonly $isPhantom = Reputation.$isPhantom;

 readonly type: ToField<String>; readonly value: ToField<"u64">; readonly positive: ToField<"bool">; readonly description: ToField<String>; readonly url: ToField<String>; readonly issuer: ToField<"address">

 private constructor(typeArgs: [], fields: ReputationFields, ) { this.$fullTypeName = composeSuiType( Reputation.$typeName, ...typeArgs ) as `${typeof PKG_V1}::account::Reputation`; this.$typeArgs = typeArgs;

 this.type = fields.type;; this.value = fields.value;; this.positive = fields.positive;; this.description = fields.description;; this.url = fields.url;; this.issuer = fields.issuer; }

 static reified( ): ReputationReified { return { typeName: Reputation.$typeName, fullTypeName: composeSuiType( Reputation.$typeName, ...[] ) as `${typeof PKG_V1}::account::Reputation`, typeArgs: [ ] as [], isPhantom: Reputation.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Reputation.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Reputation.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Reputation.fromBcs( data, ), bcs: Reputation.bcs, fromJSONField: (field: any) => Reputation.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Reputation.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Reputation.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Reputation.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Reputation.fetch( client, id, ), new: ( fields: ReputationFields, ) => { return new Reputation( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Reputation.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Reputation>> { return phantom(Reputation.reified( )); } static get p() { return Reputation.phantom() }

 static get bcs() { return bcs.struct("Reputation", {

 type: String.bcs, value: bcs.u64(), positive: bcs.bool(), description: String.bcs, url: String.bcs, issuer: bcs.bytes(32).transform({ input: (val: string) => fromHEX(val), output: (val: Uint8Array) => toHEX(val), })

}) };

 static fromFields( fields: Record<string, any> ): Reputation { return Reputation.reified( ).new( { type: decodeFromFields(String.reified(), fields.type), value: decodeFromFields("u64", fields.value), positive: decodeFromFields("bool", fields.positive), description: decodeFromFields(String.reified(), fields.description), url: decodeFromFields(String.reified(), fields.url), issuer: decodeFromFields("address", fields.issuer) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Reputation { if (!isReputation(item.type)) { throw new Error("not a Reputation type");

 }

 return Reputation.reified( ).new( { type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), value: decodeFromFieldsWithTypes("u64", item.fields.value), positive: decodeFromFieldsWithTypes("bool", item.fields.positive), description: decodeFromFieldsWithTypes(String.reified(), item.fields.description), url: decodeFromFieldsWithTypes(String.reified(), item.fields.url), issuer: decodeFromFieldsWithTypes("address", item.fields.issuer) } ) }

 static fromBcs( data: Uint8Array ): Reputation { return Reputation.fromFields( Reputation.bcs.parse(data) ) }

 toJSONField() { return {

 type: this.type,value: this.value.toString(),positive: this.positive,description: this.description,url: this.url,issuer: this.issuer,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Reputation { return Reputation.reified( ).new( { type: decodeFromJSONField(String.reified(), field.type), value: decodeFromJSONField("u64", field.value), positive: decodeFromJSONField("bool", field.positive), description: decodeFromJSONField(String.reified(), field.description), url: decodeFromJSONField(String.reified(), field.url), issuer: decodeFromJSONField("address", field.issuer) } ) }

 static fromJSON( json: Record<string, any> ): Reputation { if (json.$typeName !== Reputation.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Reputation.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Reputation { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isReputation(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Reputation object`); } return Reputation.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Reputation { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isReputation(data.bcs.type)) { throw new Error(`object at is not a Reputation object`); }

 return Reputation.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Reputation.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Reputation> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Reputation object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isReputation(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Reputation object`); }

 return Reputation.fromSuiObjectData( res.data ); }

 }

/* ============================== System =============================== */

export function isSystem(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::account::System`; }

export interface SystemFields { id: ToField<UID>; accounts: ToField<Table<"address", "address">>; accolades: ToField<Table<"address", ToPhantom<TableVec<ToPhantom<Accolade>>>>>; reputation: ToField<Table<"address", ToPhantom<TableVec<ToPhantom<Reputation>>>>> }

export type SystemReified = Reified< System, SystemFields >;

export class System implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::account::System`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = System.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::account::System`; readonly $typeArgs: []; readonly $isPhantom = System.$isPhantom;

 readonly id: ToField<UID>; readonly accounts: ToField<Table<"address", "address">>; readonly accolades: ToField<Table<"address", ToPhantom<TableVec<ToPhantom<Accolade>>>>>; readonly reputation: ToField<Table<"address", ToPhantom<TableVec<ToPhantom<Reputation>>>>>

 private constructor(typeArgs: [], fields: SystemFields, ) { this.$fullTypeName = composeSuiType( System.$typeName, ...typeArgs ) as `${typeof PKG_V1}::account::System`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.accounts = fields.accounts;; this.accolades = fields.accolades;; this.reputation = fields.reputation; }

 static reified( ): SystemReified { return { typeName: System.$typeName, fullTypeName: composeSuiType( System.$typeName, ...[] ) as `${typeof PKG_V1}::account::System`, typeArgs: [ ] as [], isPhantom: System.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => System.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => System.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => System.fromBcs( data, ), bcs: System.bcs, fromJSONField: (field: any) => System.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => System.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => System.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => System.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => System.fetch( client, id, ), new: ( fields: SystemFields, ) => { return new System( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return System.reified() }

 static phantom( ): PhantomReified<ToTypeStr<System>> { return phantom(System.reified( )); } static get p() { return System.phantom() }

 static get bcs() { return bcs.struct("System", {

 id: UID.bcs, accounts: Table.bcs, accolades: Table.bcs, reputation: Table.bcs

}) };

 static fromFields( fields: Record<string, any> ): System { return System.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), accounts: decodeFromFields(Table.reified(reified.phantom("address"), reified.phantom("address")), fields.accounts), accolades: decodeFromFields(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Accolade.reified())))), fields.accolades), reputation: decodeFromFields(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Reputation.reified())))), fields.reputation) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): System { if (!isSystem(item.type)) { throw new Error("not a System type");

 }

 return System.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), accounts: decodeFromFieldsWithTypes(Table.reified(reified.phantom("address"), reified.phantom("address")), item.fields.accounts), accolades: decodeFromFieldsWithTypes(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Accolade.reified())))), item.fields.accolades), reputation: decodeFromFieldsWithTypes(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Reputation.reified())))), item.fields.reputation) } ) }

 static fromBcs( data: Uint8Array ): System { return System.fromFields( System.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,accounts: this.accounts.toJSONField(),accolades: this.accolades.toJSONField(),reputation: this.reputation.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): System { return System.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), accounts: decodeFromJSONField(Table.reified(reified.phantom("address"), reified.phantom("address")), field.accounts), accolades: decodeFromJSONField(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Accolade.reified())))), field.accolades), reputation: decodeFromJSONField(Table.reified(reified.phantom("address"), reified.phantom(TableVec.reified(reified.phantom(Reputation.reified())))), field.reputation) } ) }

 static fromJSON( json: Record<string, any> ): System { if (json.$typeName !== System.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return System.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): System { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isSystem(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a System object`); } return System.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): System { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isSystem(data.bcs.type)) { throw new Error(`object at is not a System object`); }

 return System.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return System.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<System> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching System object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isSystem(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a System object`); }

 return System.fromSuiObjectData( res.data ); }

 }
