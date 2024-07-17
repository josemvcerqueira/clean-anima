import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../../../_framework/util";
import {Option} from "../../0x1/option/structs";
import {KioskOwnerCap} from "../../0x2/kiosk/structs";
import {ID, UID} from "../../0x2/object/structs";
import {PKG_V2, PKG_V3} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Borrow =============================== */

export function isBorrow(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V2}::personal_kiosk::Borrow`; }

export interface BorrowFields { capId: ToField<ID>; ownedId: ToField<ID> }

export type BorrowReified = Reified< Borrow, BorrowFields >;

export class Borrow implements StructClass { static readonly $typeName = `${PKG_V2}::personal_kiosk::Borrow`; static readonly $numTypeParams = 0;

 readonly $typeName = Borrow.$typeName;

 readonly $fullTypeName: `${typeof PKG_V2}::personal_kiosk::Borrow`;

 readonly $typeArgs: [];

 readonly capId: ToField<ID>; readonly ownedId: ToField<ID>

 private constructor(typeArgs: [], fields: BorrowFields, ) { this.$fullTypeName = composeSuiType( Borrow.$typeName, ...typeArgs ) as `${typeof PKG_V2}::personal_kiosk::Borrow`; this.$typeArgs = typeArgs;

 this.capId = fields.capId;; this.ownedId = fields.ownedId; }

 static reified( ): BorrowReified { return { typeName: Borrow.$typeName, fullTypeName: composeSuiType( Borrow.$typeName, ...[] ) as `${typeof PKG_V2}::personal_kiosk::Borrow`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Borrow.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Borrow.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Borrow.fromBcs( data, ), bcs: Borrow.bcs, fromJSONField: (field: any) => Borrow.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Borrow.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Borrow.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Borrow.fetch( client, id, ), new: ( fields: BorrowFields, ) => { return new Borrow( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Borrow.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Borrow>> { return phantom(Borrow.reified( )); } static get p() { return Borrow.phantom() }

 static get bcs() { return bcs.struct("Borrow", {

 cap_id: ID.bcs, owned_id: ID.bcs

}) };

 static fromFields( fields: Record<string, any> ): Borrow { return Borrow.reified( ).new( { capId: decodeFromFields(ID.reified(), fields.cap_id), ownedId: decodeFromFields(ID.reified(), fields.owned_id) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Borrow { if (!isBorrow(item.type)) { throw new Error("not a Borrow type");

 }

 return Borrow.reified( ).new( { capId: decodeFromFieldsWithTypes(ID.reified(), item.fields.cap_id), ownedId: decodeFromFieldsWithTypes(ID.reified(), item.fields.owned_id) } ) }

 static fromBcs( data: Uint8Array ): Borrow { return Borrow.fromFields( Borrow.bcs.parse(data) ) }

 toJSONField() { return {

 capId: this.capId,ownedId: this.ownedId,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Borrow { return Borrow.reified( ).new( { capId: decodeFromJSONField(ID.reified(), field.capId), ownedId: decodeFromJSONField(ID.reified(), field.ownedId) } ) }

 static fromJSON( json: Record<string, any> ): Borrow { if (json.$typeName !== Borrow.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Borrow.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Borrow { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isBorrow(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Borrow object`); } return Borrow.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Borrow> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Borrow object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isBorrow(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Borrow object`); }
 return Borrow.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== NewPersonalKiosk =============================== */

export function isNewPersonalKiosk(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V3}::personal_kiosk::NewPersonalKiosk`; }

export interface NewPersonalKioskFields { kioskId: ToField<ID> }

export type NewPersonalKioskReified = Reified< NewPersonalKiosk, NewPersonalKioskFields >;

export class NewPersonalKiosk implements StructClass { static readonly $typeName = `${PKG_V3}::personal_kiosk::NewPersonalKiosk`; static readonly $numTypeParams = 0;

 readonly $typeName = NewPersonalKiosk.$typeName;

 readonly $fullTypeName: `${typeof PKG_V3}::personal_kiosk::NewPersonalKiosk`;

 readonly $typeArgs: [];

 readonly kioskId: ToField<ID>

 private constructor(typeArgs: [], fields: NewPersonalKioskFields, ) { this.$fullTypeName = composeSuiType( NewPersonalKiosk.$typeName, ...typeArgs ) as `${typeof PKG_V3}::personal_kiosk::NewPersonalKiosk`; this.$typeArgs = typeArgs;

 this.kioskId = fields.kioskId; }

 static reified( ): NewPersonalKioskReified { return { typeName: NewPersonalKiosk.$typeName, fullTypeName: composeSuiType( NewPersonalKiosk.$typeName, ...[] ) as `${typeof PKG_V3}::personal_kiosk::NewPersonalKiosk`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => NewPersonalKiosk.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => NewPersonalKiosk.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => NewPersonalKiosk.fromBcs( data, ), bcs: NewPersonalKiosk.bcs, fromJSONField: (field: any) => NewPersonalKiosk.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => NewPersonalKiosk.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => NewPersonalKiosk.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => NewPersonalKiosk.fetch( client, id, ), new: ( fields: NewPersonalKioskFields, ) => { return new NewPersonalKiosk( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return NewPersonalKiosk.reified() }

 static phantom( ): PhantomReified<ToTypeStr<NewPersonalKiosk>> { return phantom(NewPersonalKiosk.reified( )); } static get p() { return NewPersonalKiosk.phantom() }

 static get bcs() { return bcs.struct("NewPersonalKiosk", {

 kiosk_id: ID.bcs

}) };

 static fromFields( fields: Record<string, any> ): NewPersonalKiosk { return NewPersonalKiosk.reified( ).new( { kioskId: decodeFromFields(ID.reified(), fields.kiosk_id) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): NewPersonalKiosk { if (!isNewPersonalKiosk(item.type)) { throw new Error("not a NewPersonalKiosk type");

 }

 return NewPersonalKiosk.reified( ).new( { kioskId: decodeFromFieldsWithTypes(ID.reified(), item.fields.kiosk_id) } ) }

 static fromBcs( data: Uint8Array ): NewPersonalKiosk { return NewPersonalKiosk.fromFields( NewPersonalKiosk.bcs.parse(data) ) }

 toJSONField() { return {

 kioskId: this.kioskId,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): NewPersonalKiosk { return NewPersonalKiosk.reified( ).new( { kioskId: decodeFromJSONField(ID.reified(), field.kioskId) } ) }

 static fromJSON( json: Record<string, any> ): NewPersonalKiosk { if (json.$typeName !== NewPersonalKiosk.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return NewPersonalKiosk.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): NewPersonalKiosk { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isNewPersonalKiosk(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a NewPersonalKiosk object`); } return NewPersonalKiosk.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<NewPersonalKiosk> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching NewPersonalKiosk object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isNewPersonalKiosk(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a NewPersonalKiosk object`); }
 return NewPersonalKiosk.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== OwnerMarker =============================== */

export function isOwnerMarker(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V2}::personal_kiosk::OwnerMarker`; }

export interface OwnerMarkerFields { dummyField: ToField<"bool"> }

export type OwnerMarkerReified = Reified< OwnerMarker, OwnerMarkerFields >;

export class OwnerMarker implements StructClass { static readonly $typeName = `${PKG_V2}::personal_kiosk::OwnerMarker`; static readonly $numTypeParams = 0;

 readonly $typeName = OwnerMarker.$typeName;

 readonly $fullTypeName: `${typeof PKG_V2}::personal_kiosk::OwnerMarker`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: OwnerMarkerFields, ) { this.$fullTypeName = composeSuiType( OwnerMarker.$typeName, ...typeArgs ) as `${typeof PKG_V2}::personal_kiosk::OwnerMarker`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): OwnerMarkerReified { return { typeName: OwnerMarker.$typeName, fullTypeName: composeSuiType( OwnerMarker.$typeName, ...[] ) as `${typeof PKG_V2}::personal_kiosk::OwnerMarker`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => OwnerMarker.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => OwnerMarker.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => OwnerMarker.fromBcs( data, ), bcs: OwnerMarker.bcs, fromJSONField: (field: any) => OwnerMarker.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => OwnerMarker.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => OwnerMarker.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => OwnerMarker.fetch( client, id, ), new: ( fields: OwnerMarkerFields, ) => { return new OwnerMarker( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return OwnerMarker.reified() }

 static phantom( ): PhantomReified<ToTypeStr<OwnerMarker>> { return phantom(OwnerMarker.reified( )); } static get p() { return OwnerMarker.phantom() }

 static get bcs() { return bcs.struct("OwnerMarker", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): OwnerMarker { return OwnerMarker.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): OwnerMarker { if (!isOwnerMarker(item.type)) { throw new Error("not a OwnerMarker type");

 }

 return OwnerMarker.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): OwnerMarker { return OwnerMarker.fromFields( OwnerMarker.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): OwnerMarker { return OwnerMarker.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): OwnerMarker { if (json.$typeName !== OwnerMarker.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return OwnerMarker.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): OwnerMarker { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isOwnerMarker(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a OwnerMarker object`); } return OwnerMarker.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<OwnerMarker> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching OwnerMarker object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isOwnerMarker(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a OwnerMarker object`); }
 return OwnerMarker.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== PersonalKioskCap =============================== */

export function isPersonalKioskCap(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V2}::personal_kiosk::PersonalKioskCap`; }

export interface PersonalKioskCapFields { id: ToField<UID>; cap: ToField<Option<KioskOwnerCap>> }

export type PersonalKioskCapReified = Reified< PersonalKioskCap, PersonalKioskCapFields >;

export class PersonalKioskCap implements StructClass { static readonly $typeName = `${PKG_V2}::personal_kiosk::PersonalKioskCap`; static readonly $numTypeParams = 0;

 readonly $typeName = PersonalKioskCap.$typeName;

 readonly $fullTypeName: `${typeof PKG_V2}::personal_kiosk::PersonalKioskCap`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly cap: ToField<Option<KioskOwnerCap>>

 private constructor(typeArgs: [], fields: PersonalKioskCapFields, ) { this.$fullTypeName = composeSuiType( PersonalKioskCap.$typeName, ...typeArgs ) as `${typeof PKG_V2}::personal_kiosk::PersonalKioskCap`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.cap = fields.cap; }

 static reified( ): PersonalKioskCapReified { return { typeName: PersonalKioskCap.$typeName, fullTypeName: composeSuiType( PersonalKioskCap.$typeName, ...[] ) as `${typeof PKG_V2}::personal_kiosk::PersonalKioskCap`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => PersonalKioskCap.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => PersonalKioskCap.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => PersonalKioskCap.fromBcs( data, ), bcs: PersonalKioskCap.bcs, fromJSONField: (field: any) => PersonalKioskCap.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => PersonalKioskCap.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => PersonalKioskCap.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => PersonalKioskCap.fetch( client, id, ), new: ( fields: PersonalKioskCapFields, ) => { return new PersonalKioskCap( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return PersonalKioskCap.reified() }

 static phantom( ): PhantomReified<ToTypeStr<PersonalKioskCap>> { return phantom(PersonalKioskCap.reified( )); } static get p() { return PersonalKioskCap.phantom() }

 static get bcs() { return bcs.struct("PersonalKioskCap", {

 id: UID.bcs, cap: Option.bcs(KioskOwnerCap.bcs)

}) };

 static fromFields( fields: Record<string, any> ): PersonalKioskCap { return PersonalKioskCap.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), cap: decodeFromFields(Option.reified(KioskOwnerCap.reified()), fields.cap) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): PersonalKioskCap { if (!isPersonalKioskCap(item.type)) { throw new Error("not a PersonalKioskCap type");

 }

 return PersonalKioskCap.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), cap: decodeFromFieldsWithTypes(Option.reified(KioskOwnerCap.reified()), item.fields.cap) } ) }

 static fromBcs( data: Uint8Array ): PersonalKioskCap { return PersonalKioskCap.fromFields( PersonalKioskCap.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,cap: fieldToJSON<Option<KioskOwnerCap>>(`${Option.$typeName}<${KioskOwnerCap.$typeName}>`, this.cap),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): PersonalKioskCap { return PersonalKioskCap.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), cap: decodeFromJSONField(Option.reified(KioskOwnerCap.reified()), field.cap) } ) }

 static fromJSON( json: Record<string, any> ): PersonalKioskCap { if (json.$typeName !== PersonalKioskCap.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return PersonalKioskCap.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): PersonalKioskCap { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isPersonalKioskCap(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a PersonalKioskCap object`); } return PersonalKioskCap.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<PersonalKioskCap> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching PersonalKioskCap object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isPersonalKioskCap(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a PersonalKioskCap object`); }
 return PersonalKioskCap.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
