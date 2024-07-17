import {String} from "../../_dependencies/source/0x1/string/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Upgrade =============================== */

export function isUpgrade(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_upgrade::Upgrade`; }

export interface UpgradeFields { name: ToField<String>; image: ToField<String> }

export type UpgradeReified = Reified< Upgrade, UpgradeFields >;

export class Upgrade implements StructClass { static readonly $typeName = `${PKG_V1}::act_upgrade::Upgrade`; static readonly $numTypeParams = 0;

 readonly $typeName = Upgrade.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_upgrade::Upgrade`;

 readonly $typeArgs: [];

 readonly name: ToField<String>; readonly image: ToField<String>

 private constructor(typeArgs: [], fields: UpgradeFields, ) { this.$fullTypeName = composeSuiType( Upgrade.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_upgrade::Upgrade`; this.$typeArgs = typeArgs;

 this.name = fields.name;; this.image = fields.image; }

 static reified( ): UpgradeReified { return { typeName: Upgrade.$typeName, fullTypeName: composeSuiType( Upgrade.$typeName, ...[] ) as `${typeof PKG_V1}::act_upgrade::Upgrade`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Upgrade.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Upgrade.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Upgrade.fromBcs( data, ), bcs: Upgrade.bcs, fromJSONField: (field: any) => Upgrade.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Upgrade.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Upgrade.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Upgrade.fetch( client, id, ), new: ( fields: UpgradeFields, ) => { return new Upgrade( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Upgrade.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Upgrade>> { return phantom(Upgrade.reified( )); } static get p() { return Upgrade.phantom() }

 static get bcs() { return bcs.struct("Upgrade", {

 name: String.bcs, image: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Upgrade { return Upgrade.reified( ).new( { name: decodeFromFields(String.reified(), fields.name), image: decodeFromFields(String.reified(), fields.image) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Upgrade { if (!isUpgrade(item.type)) { throw new Error("not a Upgrade type");

 }

 return Upgrade.reified( ).new( { name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), image: decodeFromFieldsWithTypes(String.reified(), item.fields.image) } ) }

 static fromBcs( data: Uint8Array ): Upgrade { return Upgrade.fromFields( Upgrade.bcs.parse(data) ) }

 toJSONField() { return {

 name: this.name,image: this.image,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Upgrade { return Upgrade.reified( ).new( { name: decodeFromJSONField(String.reified(), field.name), image: decodeFromJSONField(String.reified(), field.image) } ) }

 static fromJSON( json: Record<string, any> ): Upgrade { if (json.$typeName !== Upgrade.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Upgrade.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Upgrade { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isUpgrade(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Upgrade object`); } return Upgrade.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Upgrade> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Upgrade object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isUpgrade(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Upgrade object`); }
 return Upgrade.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
