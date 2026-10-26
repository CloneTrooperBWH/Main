file="transactions.log"

awk '{
	name=$1
	incom=$2
	expen=$3
	arr1[name] += incom
	arr2[name] += expen
}
END {
	for (i in arr1){
		if (arr2[i] > arr1[i]){
			print i
		}
	}
}
' "$file"
#я долго думал почему если у человека расходы больше доходов то он дюпает...
