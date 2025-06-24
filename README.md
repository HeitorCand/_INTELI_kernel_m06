# Kernel Assembly - Boot Sector

Um simples bootloader/kernel escrito em Assembly x86 que interage com o usuário.

## Descrição

Este projeto implementa um bootloader básico que:
- Pergunta o nome do usuário
- Lê a entrada do teclado
- Exibe uma mensagem de boas-vindas personalizada

## Demonstração

https://drive.google.com/file/d/13ddSeb36el8PDR434pv8uAhHjPQCZWXo/view?usp=sharing

*Vídeo demonstrativo: [Gravação de Tela 2025-06-23 às 22.18.08.mov](Gravação%20de%20Tela%202025-06-23%20às%2022.18.08.mov)*

## Arquivos

- [`kernel.s`](kernel.s) - Código fonte principal em Assembly
- `boot.bin` - Arquivo binário compilado do bootloader
- `Gravação de Tela 2025-06-23 às 22.18.08.mov` - Vídeo demonstrativo da execução

## Funcionalidades

### Funções implementadas:
- [`showString`](kernel.s) - Exibe strings na tela
- [`printChar`](kernel.s) - Imprime caracteres individuais
- [`readLine`](kernel.s) - Lê entrada do usuário com suporte a backspace

### Fluxo do programa:
1. Exibe "Qual seu nome?"
2. Aguarda entrada do usuário (máximo 30 caracteres)
3. Exibe mensagem de boas-vindas com o nome inserido

## Como compilar

```bash
nasm -f bin kernel.s -o boot.bin
```

## Como executar

Execute o arquivo `boot.bin` em um emulador como QEMU:

```bash
qemu-system-x86_64 -fda boot.bin
```

## Características técnicas

- Bootloader de 512 bytes (boot sector)
- Compatível com BIOS
- Usa interrupções BIOS para entrada/saída
- Segmento de dados em 0x7C0