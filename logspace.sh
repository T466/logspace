#!/bin/bash
 
# Diretório de logs
LOG_DIR="/var/log"
 
# Arquivo de saída para o relatório
OUTPUT_FILE="/tmp/log_growth_report.txt"
 
# Data e hora atual
DATE=$(date +'%Y-%m-%d %H:%M:%S')
 
# Cabeçalho do relatório
echo "Relatório de Crescimento de Logs - $DATE" > "$OUTPUT_FILE"
echo "---------------------------------------------" >> "$OUTPUT_FILE"
 
# Listar e verificar o tamanho dos arquivos de log
for file in $(find "$LOG_DIR" -type f -name '*.log'); do
    size=$(du -sh "$file" | awk '{print $1}')
    echo "Arquivo: $file, Tamanho: $size" >> "$OUTPUT_FILE"
done
 
# Adicionar separador
echo "" >> "$OUTPUT_FILE"
 
# Exibir os 10 maiores arquivos de log por tamanho
echo "Top 10 Maiores Arquivos de Log:" >> "$OUTPUT_FILE"
echo "---------------------------------------------" >> "$OUTPUT_FILE"
du -h --max-depth=1 "$LOG_DIR"/*.log 2>/dev/null | sort -hr | head -n 10 >> "$OUTPUT_FILE"
 
# Exibir espaço total ocupado por logs
echo "" >> "$OUTPUT_FILE"
echo "Espaço Total Ocupado por Logs:" >> "$OUTPUT_FILE"
echo "---------------------------------------------" >> "$OUTPUT_FILE"
du -sh "$LOG_DIR" >> "$OUTPUT_FILE"
 
# Exibir conclusão
echo "" >> "$OUTPUT_FILE"
echo "Relatório gerado com sucesso em $DATE" >> "$OUTPUT_FILE"
 
# Exibir relatório na saída padrão
cat "$OUTPUT_FILE"
 
# Limpar arquivo de relatório antigo
rm -f "$OUTPUT_FILE"

echo " "
echo "Arquivos Temporarios:"
echo ---------------------------------------------------------
# Diretório para monitorar
TEMP_DIR="/tmp"

# Arquivo temporário para armazenar a contagem e tamanho total
SUMMARY_FILE="/tmp/temp_file_summary.txt"

# Data atual
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Encontrar arquivos no diretório TEMP_DIR e calcular a quantidade e tamanho total
find $TEMP_DIR -type f -exec du -b {} + | awk '{ total += $1; count++ } END { print count, total }' > $SUMMARY_FILE

# Ler a contagem e o tamanho total dos arquivos do resumo
read -r FILE_COUNT TOTAL_SIZE < $SUMMARY_FILE

# Exibir o número de arquivos e o tamanho total no terminal
echo "[$CURRENT_DATE] Total de arquivos temporários em $TEMP_DIR: $FILE_COUNT"
echo "[$CURRENT_DATE] Tamanho total dos arquivos temporários em $TEMP_DIR: $TOTAL_SIZE bytes"

# Limpar o arquivo temporário de resumo
rm $SUMMARY_FILE
