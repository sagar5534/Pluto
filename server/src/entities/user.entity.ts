import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Account } from './account.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ default: true })
  isActive: boolean;

  @OneToMany(type => Account, account => account.user)
  accounts: Account[];
}
