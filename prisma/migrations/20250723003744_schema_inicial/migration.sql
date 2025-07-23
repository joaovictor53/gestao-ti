-- CreateTable
CREATE TABLE "Usuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nomeCompleto" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senhaHash" TEXT NOT NULL,
    "setor" TEXT,
    "role" TEXT NOT NULL DEFAULT 'USUARIO',
    "dataCriacao" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ativo" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "Ativo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nomeAtivo" TEXT NOT NULL,
    "tipoAtivo" TEXT NOT NULL,
    "numeroSerie" TEXT,
    "patrimonio" TEXT,
    "marca" TEXT,
    "modelo" TEXT,
    "status" TEXT NOT NULL,
    "localizacao" TEXT,
    "dataAquisicao" DATETIME,
    "idUsuarioResponsavel" INTEGER,
    CONSTRAINT "Ativo_idUsuarioResponsavel_fkey" FOREIGN KEY ("idUsuarioResponsavel") REFERENCES "Usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Chamado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ABERTO',
    "prioridade" TEXT NOT NULL DEFAULT 'MEDIA',
    "dataAbertura" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataFechamento" DATETIME,
    "idSolicitante" INTEGER NOT NULL,
    "idTecnicoResponsavel" INTEGER,
    CONSTRAINT "Chamado_idSolicitante_fkey" FOREIGN KEY ("idSolicitante") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Chamado_idTecnicoResponsavel_fkey" FOREIGN KEY ("idTecnicoResponsavel") REFERENCES "Usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Comentario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "texto" TEXT NOT NULL,
    "dataComentario" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ehInterno" BOOLEAN NOT NULL DEFAULT false,
    "idChamado" INTEGER NOT NULL,
    "idAutor" INTEGER NOT NULL,
    CONSTRAINT "Comentario_idChamado_fkey" FOREIGN KEY ("idChamado") REFERENCES "Chamado" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Comentario_idAutor_fkey" FOREIGN KEY ("idAutor") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ChamadosAtivos" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_ChamadosAtivos_A_fkey" FOREIGN KEY ("A") REFERENCES "Ativo" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ChamadosAtivos_B_fkey" FOREIGN KEY ("B") REFERENCES "Chamado" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Ativo_nomeAtivo_key" ON "Ativo"("nomeAtivo");

-- CreateIndex
CREATE UNIQUE INDEX "Ativo_numeroSerie_key" ON "Ativo"("numeroSerie");

-- CreateIndex
CREATE UNIQUE INDEX "Ativo_patrimonio_key" ON "Ativo"("patrimonio");

-- CreateIndex
CREATE UNIQUE INDEX "_ChamadosAtivos_AB_unique" ON "_ChamadosAtivos"("A", "B");

-- CreateIndex
CREATE INDEX "_ChamadosAtivos_B_index" ON "_ChamadosAtivos"("B");
