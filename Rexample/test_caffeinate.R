system("caffeinate -im", wait = FALSE)
print("start")
for (i in 1:60) {
  Sys.sleep(1)
  print(i)
}