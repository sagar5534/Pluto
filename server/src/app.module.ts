import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { controllers } from 'src/controllers';
import { services } from 'src/services';
import { entities } from 'src/entities';
import { repositories } from 'src/repositories';
import { ModuleRef } from '@nestjs/core';

const common = [...services, ...repositories];

const imports = [
  TypeOrmModule.forRootAsync({
    inject: [ModuleRef],
    useFactory: () => {
      return {
        type: 'sqlite',
        database: 'db/pluto.db',
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: true, //PROD CHANGE TO FALSE
        logging: true,
      };
    },
  }),
  TypeOrmModule.forFeature(entities),
];

@Module({
  imports: [...imports],
  controllers: [...controllers],
  providers: [...common],
})
export class AppModule {}
