import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { Account } from './account.entity';

@Entity()
export class Transaction {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('decimal')
  amount: number;

  @Column('date')
  date: Date;

  @Column()
  merchant: string;
  
  @Column()
  description: string;

  @ManyToOne(() => Account, account => account.transactions)
  account: Account;

}
