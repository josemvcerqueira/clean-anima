import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64} from "@mysten/sui/utils";

/* ============================== ProfilePictures =============================== */

export function isProfilePictures(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::profile_pictures::ProfilePictures`; }

export interface ProfilePicturesFields { id: ToField<UID>; hashToIpfs: ToField<Table<ToPhantom<Vector<"u8">>, ToPhantom<String>>> }

export type ProfilePicturesReified = Reified< ProfilePictures, ProfilePicturesFields >;

export class ProfilePictures implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::profile_pictures::ProfilePictures`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = ProfilePictures.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::profile_pictures::ProfilePictures`; readonly $typeArgs: []; readonly $isPhantom = ProfilePictures.$isPhantom;

 readonly id: ToField<UID>; readonly hashToIpfs: ToField<Table<ToPhantom<Vector<"u8">>, ToPhantom<String>>>

 private constructor(typeArgs: [], fields: ProfilePicturesFields, ) { this.$fullTypeName = composeSuiType( ProfilePictures.$typeName, ...typeArgs ) as `${typeof PKG_V1}::profile_pictures::ProfilePictures`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.hashToIpfs = fields.hashToIpfs; }

 static reified( ): ProfilePicturesReified { return { typeName: ProfilePictures.$typeName, fullTypeName: composeSuiType( ProfilePictures.$typeName, ...[] ) as `${typeof PKG_V1}::profile_pictures::ProfilePictures`, typeArgs: [ ] as [], isPhantom: ProfilePictures.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => ProfilePictures.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => ProfilePictures.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => ProfilePictures.fromBcs( data, ), bcs: ProfilePictures.bcs, fromJSONField: (field: any) => ProfilePictures.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => ProfilePictures.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => ProfilePictures.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => ProfilePictures.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => ProfilePictures.fetch( client, id, ), new: ( fields: ProfilePicturesFields, ) => { return new ProfilePictures( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return ProfilePictures.reified() }

 static phantom( ): PhantomReified<ToTypeStr<ProfilePictures>> { return phantom(ProfilePictures.reified( )); } static get p() { return ProfilePictures.phantom() }

 static get bcs() { return bcs.struct("ProfilePictures", {

 id: UID.bcs, hash_to_ipfs: Table.bcs

}) };

 static fromFields( fields: Record<string, any> ): ProfilePictures { return ProfilePictures.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), hashToIpfs: decodeFromFields(Table.reified(reified.phantom(reified.vector("u8")), reified.phantom(String.reified())), fields.hash_to_ipfs) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): ProfilePictures { if (!isProfilePictures(item.type)) { throw new Error("not a ProfilePictures type");

 }

 return ProfilePictures.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), hashToIpfs: decodeFromFieldsWithTypes(Table.reified(reified.phantom(reified.vector("u8")), reified.phantom(String.reified())), item.fields.hash_to_ipfs) } ) }

 static fromBcs( data: Uint8Array ): ProfilePictures { return ProfilePictures.fromFields( ProfilePictures.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,hashToIpfs: this.hashToIpfs.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): ProfilePictures { return ProfilePictures.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), hashToIpfs: decodeFromJSONField(Table.reified(reified.phantom(reified.vector("u8")), reified.phantom(String.reified())), field.hashToIpfs) } ) }

 static fromJSON( json: Record<string, any> ): ProfilePictures { if (json.$typeName !== ProfilePictures.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return ProfilePictures.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): ProfilePictures { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isProfilePictures(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a ProfilePictures object`); } return ProfilePictures.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): ProfilePictures { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isProfilePictures(data.bcs.type)) { throw new Error(`object at is not a ProfilePictures object`); }

 return ProfilePictures.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return ProfilePictures.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<ProfilePictures> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching ProfilePictures object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isProfilePictures(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a ProfilePictures object`); }

 return ProfilePictures.fromSuiObjectData( res.data ); }

 }
