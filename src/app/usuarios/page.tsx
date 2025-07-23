// src/app/usuarios/page.tsx
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// Esta função busca os dados diretamente no servidor antes de renderizar a página
async function getUsuarios() {
  const usuarios = await prisma.usuario.findMany({
    orderBy: { nomeCompleto: 'asc' },
  });
  return usuarios;
}

// A página é um componente assíncrono
export default async function PaginaUsuarios() {
  const usuarios = await getUsuarios();

  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold text-white mb-6">
        Lista de Contribuidores
      </h1>
      <div className="bg-white shadow-md rounded-lg p-6">
        {usuarios.length === 0 ? (
          <p>Nenhum usuário cadastrado ainda.</p>
        ) : (
          <ul>
            {usuarios.map((usuario) => (
              <li key={usuario.id} className="border-b py-2">
                <p className="font-semibold">{usuario.nomeCompleto}</p>
                <p className="text-sm text-bla">{usuario.email}</p>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}