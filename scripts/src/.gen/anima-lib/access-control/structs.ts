import * as reified from "../../_framework/reified";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {VecSet} from "../../_dependencies/source/0x2/vec-set/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64, fromHEX, toHEX} from "@mysten/sui/utils";

/* ============================== AccessControl =============================== */

export function isAccessControl(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::access_control::AccessControl`; }

export interface AccessControlFields { id: ToField<UID>; roles: ToField<VecMap<Vector<"u8">, VecSet<"address">>> }

export type AccessControlReified = Reified< AccessControl, AccessControlFields >;

export class AccessControl implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::access_control::AccessControl`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = AccessControl.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::access_control::AccessControl`; readonly $typeArgs: []; readonly $isPhantom = AccessControl.$isPhantom;

 readonly id: ToField<UID>; readonly roles: ToField<VecMap<Vector<"u8">, VecSet<"address">>>

 private constructor(typeArgs: [], fields: AccessControlFields, ) { this.$fullTypeName = composeSuiType( AccessControl.$typeName, ...typeArgs ) as `${typeof PKG_V1}::access_control::AccessControl`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.roles = fields.roles; }

 static reified( ): AccessControlReified { return { typeName: AccessControl.$typeName, fullTypeName: composeSuiType( AccessControl.$typeName, ...[] ) as `${typeof PKG_V1}::access_control::AccessControl`, typeArgs: [ ] as [], isPhantom: AccessControl.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AccessControl.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AccessControl.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AccessControl.fromBcs( data, ), bcs: AccessControl.bcs, fromJSONField: (field: any) => AccessControl.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AccessControl.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AccessControl.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => AccessControl.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => AccessControl.fetch( client, id, ), new: ( fields: AccessControlFields, ) => { return new AccessControl( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return AccessControl.reified() }

 static phantom( ): PhantomReified<ToTypeStr<AccessControl>> { return phantom(AccessControl.reified( )); } static get p() { return AccessControl.phantom() }

 static get bcs() { return bcs.struct("AccessControl", {

 id: UID.bcs, roles: VecMap.bcs(bcs.vector(bcs.u8()), VecSet.bcs(bcs.bytes(32).transform({ input: (val: string) => fromHEX(val), output: (val: Uint8Array) => toHEX(val), })))

}) };

 static fromFields( fields: Record<string, any> ): AccessControl { return AccessControl.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), roles: decodeFromFields(VecMap.reified(reified.vector("u8"), VecSet.reified("address")), fields.roles) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): AccessControl { if (!isAccessControl(item.type)) { throw new Error("not a AccessControl type");

 }

 return AccessControl.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), roles: decodeFromFieldsWithTypes(VecMap.reified(reified.vector("u8"), VecSet.reified("address")), item.fields.roles) } ) }

 static fromBcs( data: Uint8Array ): AccessControl { return AccessControl.fromFields( AccessControl.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,roles: this.roles.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): AccessControl { return AccessControl.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), roles: decodeFromJSONField(VecMap.reified(reified.vector("u8"), VecSet.reified("address")), field.roles) } ) }

 static fromJSON( json: Record<string, any> ): AccessControl { if (json.$typeName !== AccessControl.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return AccessControl.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): AccessControl { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAccessControl(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a AccessControl object`); } return AccessControl.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): AccessControl { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAccessControl(data.bcs.type)) { throw new Error(`object at is not a AccessControl object`); }

 return AccessControl.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return AccessControl.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<AccessControl> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AccessControl object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAccessControl(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AccessControl object`); }

 return AccessControl.fromSuiObjectData( res.data ); }

 }

/* ============================== Admin =============================== */

export function isAdmin(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::access_control::Admin`; }

export interface AdminFields { id: ToField<UID>; accessControl: ToField<"address"> }

export type AdminReified = Reified< Admin, AdminFields >;

export class Admin implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::access_control::Admin`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Admin.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::access_control::Admin`; readonly $typeArgs: []; readonly $isPhantom = Admin.$isPhantom;

 readonly id: ToField<UID>; readonly accessControl: ToField<"address">

 private constructor(typeArgs: [], fields: AdminFields, ) { this.$fullTypeName = composeSuiType( Admin.$typeName, ...typeArgs ) as `${typeof PKG_V1}::access_control::Admin`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.accessControl = fields.accessControl; }

 static reified( ): AdminReified { return { typeName: Admin.$typeName, fullTypeName: composeSuiType( Admin.$typeName, ...[] ) as `${typeof PKG_V1}::access_control::Admin`, typeArgs: [ ] as [], isPhantom: Admin.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Admin.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Admin.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Admin.fromBcs( data, ), bcs: Admin.bcs, fromJSONField: (field: any) => Admin.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Admin.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Admin.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Admin.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Admin.fetch( client, id, ), new: ( fields: AdminFields, ) => { return new Admin( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Admin.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Admin>> { return phantom(Admin.reified( )); } static get p() { return Admin.phantom() }

 static get bcs() { return bcs.struct("Admin", {

 id: UID.bcs, access_control: bcs.bytes(32).transform({ input: (val: string) => fromHEX(val), output: (val: Uint8Array) => toHEX(val), })

}) };

 static fromFields( fields: Record<string, any> ): Admin { return Admin.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), accessControl: decodeFromFields("address", fields.access_control) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Admin { if (!isAdmin(item.type)) { throw new Error("not a Admin type");

 }

 return Admin.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), accessControl: decodeFromFieldsWithTypes("address", item.fields.access_control) } ) }

 static fromBcs( data: Uint8Array ): Admin { return Admin.fromFields( Admin.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,accessControl: this.accessControl,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Admin { return Admin.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), accessControl: decodeFromJSONField("address", field.accessControl) } ) }

 static fromJSON( json: Record<string, any> ): Admin { if (json.$typeName !== Admin.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Admin.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Admin { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAdmin(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Admin object`); } return Admin.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Admin { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isAdmin(data.bcs.type)) { throw new Error(`object at is not a Admin object`); }

 return Admin.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Admin.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Admin> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Admin object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAdmin(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Admin object`); }

 return Admin.fromSuiObjectData( res.data ); }

 }
