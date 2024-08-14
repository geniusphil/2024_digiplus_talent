#!/usr/bin/sh
#SBATCH -A GOV113044        # Account name/project number
#SBATCH -J FastQC_job       # Job name
#SBATCH -p ngscourse92G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14               # 使用的數 請參考Queue資源設定 
#SBATCH --mem=92g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o /home/p6elin0111/results/FastQC_out.log          # Path to the standard output file 
#SBATCH -e /home/p6elin0111/results/FastQC_err.log          # Path to the standard error ouput file
#SBATCH --mail-user=genius.philip@gmail.com    # email
#SBATCH --mail-type=ALL              # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

FASTQC=/opt/ohpc/Taiwania3/pkg/biology/FastQC/FastQC_v0.11.9/fastqc
$FASTQC -o /home/p6elin0111/2024_digiplus_talent/Hand-On/ngs/results /home/p6elin0111/2024_digiplus_talent/Hand-On/ngs/HG00403.*.fq.gz
