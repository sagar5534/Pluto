import { Optional } from "@nestjs/common";
import { IsBoolean, IsEnum, IsNotEmpty, IsOptional } from "class-validator";
import { Account } from "src/entities/account.entity";
import { AccountType } from "src/enums";

export class AccountResponseDto {
  id!: number;
  name!: string;
  type!: AccountType;
  isActive!: boolean;
}

export class CreateAccountDto {
  @IsNotEmpty()
  name!: string;

  @IsEnum(AccountType)
  type!: AccountType;
}

export class UpdateAccountDto {
  @IsOptional()
  @IsNotEmpty()
  name?: string;

  @IsOptional()
  @IsEnum(AccountType)
  type?: AccountType;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}

// export const mapAccount = (entity: Account): AccountResponseDto => {
//   return {  
//     id: entity.id,
//     name: entity.name,
//     type: entity.type,
//     isActive: entity.isActive
//   };
// };