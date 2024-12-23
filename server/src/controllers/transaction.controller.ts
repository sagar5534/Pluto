import { Body, Controller, Delete, Get, Param, Patch, Post } from "@nestjs/common";
import { CreateTransactionDto, TransactionResponseDto, UpdateTransactionDto } from "src/dtos/transaction.dto";
import { TransactionService } from "src/services/transaction.service";

@Controller('transaction')
export class TransactionController {
  constructor(private service: TransactionService) {}

  @Get()
  getAllTransactions(): Promise<TransactionResponseDto[]> {
    return this.service.getAll();
  }

  @Post()
  createTransaction(@Body() transactionData: CreateTransactionDto): Promise<TransactionResponseDto> {
    console.log(transactionData);
    return this.service.create(transactionData);
  }

  @Patch(':id')
  updateTransaction(
    @Param('id') id: number,
    @Body() dto: UpdateTransactionDto,
  ): Promise<TransactionResponseDto> {
    return this.service.update(id, dto);
  }

  @Delete(':id')
  deleteTransaction(@Param('id') id: number): Promise<void> {
    return this.service.delete(id);
  }

}