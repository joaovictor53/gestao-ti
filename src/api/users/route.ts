// src/app/api/usuarios/route.ts
import { PrismaClient } from '@prisma/client';
import { NextResponse } from 'next/server';

// Cria uma única instância do Prisma Client para ser usada na aplicação
const prisma = new PrismaClient();

// Função que lida com requisições GET para /api/usuarios
export async function GET() {
  try {
    const usuarios = await prisma.usuario.findMany();
    return NextResponse.json(usuarios);
  } catch (error) {
    console.error(error); // Log do erro no servidor
    return NextResponse.json(
      { message: "Erro ao buscar usuários." },
      { status: 500 }
    );
  }
}