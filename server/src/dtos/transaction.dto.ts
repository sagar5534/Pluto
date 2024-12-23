import { Optional } from "@nestjs/common";
import { IsDate, IsNotEmpty, IsNumber, IsOptional } from "class-validator";
import { Account } from "src/entities/account.entity";

export class TransactionResponseDto {
  id!: number;
  amount!: number;
  date!: Date;
  merchant!: string;
  description!: string;
  account!: Account;
}

export class CreateTransactionDto {
  // @IsNumber()
  amount!: number;

  // @IsDate()
  date!: Date;

  // @IsNotEmpty()
  merchant!: string;

  // @Optional()
  description!: string;

  // @IsNotEmpty()
  // @IsNumber()
  account!: Account;
}

export class UpdateTransactionDto {
  @IsOptional()
  @IsNumber()
  amount!: number;

  @IsOptional()
  @IsDate()
  date!: Date;

  @IsOptional()
  @IsNotEmpty()
  merchant!: string;

  @Optional()
  description!: string;

  @IsOptional()
  @IsNotEmpty()
  @IsNumber()
  account!: Account;
}
