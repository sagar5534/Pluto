import { Body, Controller, Delete, Get, Param, Patch, Post } from "@nestjs/common";
import { AccountResponseDto, CreateAccountDto, UpdateAccountDto } from "src/dtos/account.dto";
import { AccountService } from "src/services/account.service";

@Controller('account')
export class AccountController {
  constructor(private service: AccountService) {}

  @Get()
  getAllAccounts(): Promise<AccountResponseDto[]> {
    return this.service.getAll();
  }

  @Get('/timeline')
  getAllAccountTimeline(): Promise<AccountResponseDto[]> {
    return this.service.getMonthlyBalances();
  }

  @Post()
  createAccount(@Body() accountData: CreateAccountDto): Promise<AccountResponseDto> {
    return this.service.create(accountData);
  }

  @Patch(':id')
  updateAccount(
    @Param('id') id: number,
    @Body() dto: UpdateAccountDto,
  ): Promise<AccountResponseDto> {
    return this.service.update(id, dto);
  }

  @Delete(':id')
  deleteAccount(@Param('id') id: number): Promise<void> {
    return this.service.delete(id);
  }

}