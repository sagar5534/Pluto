import { AccountType } from 'src/enums';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany, ManyToOne } from 'typeorm';
import { Transaction } from './transaction.entity';
import { User } from './user.entity';

@Entity()
export class Account {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, user => user.accounts)
  user: User;

  @Column()
  name: string;

  @Column()
  type: AccountType;

  @Column({ default: true })
  isActive: boolean;

  @OneToMany(type => Transaction, transaction => transaction.account)
  transactions: Transaction[];
}
