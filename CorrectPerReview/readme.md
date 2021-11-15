# ฉบับแก้ตามคำแนะนำของผู้ทรงคุณวุฒิ

แก้
  * ```b202b.tex```
    * เพิ่ม ```raggedbottom``` อนุญาตให้ แต่ละหน้าไม่ต้องเขียนจนเต็มหน้า (น่าจะลด overfull หรือ underfull ได้ ดู log file) 
  * ```03ann.tex```
    * แก้ไข "**ไหล**ของเหล่ายักษ์." เป็น "**ไหล่**ของเหล่ายักษ์"
  * ```06conv.tex```
    * แก้ไขคำซ้ำซ้อน "...(fully connected layer) (Fully Connected Layer)" เป็น "...(fully connected layer)"
  * การเตรียม pdf เพื่อพิมพ์ เนื่องจากเครื่องพิมพ์อาจไม่มีฟอนต์บางอย่างที่เลือกใช้ วิธีบรรเทา คือ การทำ pdf ที่มีฟอนต์เข้าไปด้วย

```
xelatex b202b.tex
xelatex b202b.tex
bibtex b202b

makeindex b202b % single index
makeindex english % separated index June 15, 2021.
makeindex thai % separated index June 15, 2021.

xelatex b202b.tex
xelatex b202b.tex

C:\"Program Files"\gs\gs9.54.0\bin\gswin64c -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sOutputFile=b202b_fixed.pdf -f b202b.pdf
```

ปล. ฉบับนี้ไม่จำเป็นต้องตรงกับฉบับพิมพ์จริง 100%


# แผนหลังการส่งฉบับผู้ทรง

ระดับหนึ่ง
  * เพิ่มรูปของรูปแบบ ในหน้าหนึ่งบทที่หนึ่ง (เพื่อ แสดงความต่างจากเวอร์ชั่นบนเวป)
    * ทำแล้ว เพิ่มรูป ภาพใหญ่ของการรู้จำรูปแบบและการเรียนรู้ของเครื่อง (2 พย 64) 
  * เพิ่ม Inception
  * เพิ่ม Transformer
  * CTC loss (Connectionist Temporal Classification Loss)

ระดับสอง
  * ทำ NLP ให้สมบูรณ์ (Andrew Ng's Sequence Model)
  * เพิ่ม side stories: Quantum properties and computing, Entropy and life, Pattern of Lives (trophic cascade)
  * เพิ่ม computing exercises: evolution

ระดับสาม
  * simulated annealing
  * genetic algorithm
  * PCA, K-means, 
  * facenet: triplet loss
  * PAF
