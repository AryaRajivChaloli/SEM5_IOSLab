
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 50 2e 10 80       	mov    $0x80102e50,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 60 6f 10 80       	push   $0x80106f60
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 d5 41 00 00       	call   80104230 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 6f 10 80       	push   $0x80106f67
80100097:	50                   	push   %eax
80100098:	e8 63 40 00 00       	call   80104100 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 a7 42 00 00       	call   80104390 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 d9 42 00 00       	call   80104440 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 3f 00 00       	call   80104140 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 5d 1f 00 00       	call   801020e0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 6f 10 80       	push   $0x80106f6e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 2d 40 00 00       	call   801041e0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 17 1f 00 00       	jmp    801020e0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 6f 10 80       	push   $0x80106f7f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ec 3f 00 00       	call   801041e0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 3f 00 00       	call   801041a0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 80 41 00 00       	call   80104390 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 df 41 00 00       	jmp    80104440 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 6f 10 80       	push   $0x80106f86
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 bb 14 00 00       	call   80101740 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 ff 40 00 00       	call   80104390 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 6e 3a 00 00       	call   80103d30 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 99 34 00 00       	call   80103770 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 55 41 00 00       	call   80104440 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 6d 13 00 00       	call   80101660 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 f5 40 00 00       	call   80104440 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 13 00 00       	call   80101660 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 52 23 00 00       	call   801026e0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 8d 6f 10 80       	push   $0x80106f8d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 db 78 10 80 	movl   $0x801078db,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 93 3e 00 00       	call   80104250 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 a1 6f 10 80       	push   $0x80106fa1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 f1 56 00 00       	call   80105b10 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 38 56 00 00       	call   80105b10 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 2c 56 00 00       	call   80105b10 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 20 56 00 00       	call   80105b10 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 27 40 00 00       	call   80104540 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 62 3f 00 00       	call   80104490 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 a5 6f 10 80       	push   $0x80106fa5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 d0 6f 10 80 	movzbl -0x7fef9030(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 2c 11 00 00       	call   80101740 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 70 3d 00 00       	call   80104390 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 f4 3d 00 00       	call   80104440 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 0b 10 00 00       	call   80101660 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 2e 3d 00 00       	call   80104440 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 b8 6f 10 80       	mov    $0x80106fb8,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 c3 3b 00 00       	call   80104390 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 bf 6f 10 80       	push   $0x80106fbf
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 88 3b 00 00       	call   80104390 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100836:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 d3 3b 00 00       	call   80104440 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008f1:	68 a0 ff 10 80       	push   $0x8010ffa0
801008f6:	e8 e5 35 00 00       	call   80103ee0 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100934:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 54 36 00 00       	jmp    80103fd0 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 c8 6f 10 80       	push   $0x80106fc8
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 7b 38 00 00       	call   80104230 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 b2 18 00 00       	call   80102290 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 6f 2d 00 00       	call   80103770 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 34 21 00 00       	call   80102b40 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 99 14 00 00       	call   80101eb0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 33 0c 00 00       	call   80101660 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 02 0f 00 00       	call   80101940 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 a1 0e 00 00       	call   801018f0 <iunlockput>
    end_op();
80100a4f:	e8 5c 21 00 00       	call   80102bb0 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 27 62 00 00       	call   80106ca0 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 73 0e 00 00       	call   80101940 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 e7 5f 00 00       	call   80106af0 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 f1 5e 00 00       	call   80106a30 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 c2 60 00 00       	call   80106c20 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 81 0d 00 00       	call   801018f0 <iunlockput>
  end_op();
80100b6f:	e8 3c 20 00 00       	call   80102bb0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 56 5f 00 00       	call   80106af0 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 6f 60 00 00       	call   80106c20 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 ed 1f 00 00       	call   80102bb0 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 e1 6f 10 80       	push   $0x80106fe1
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 4a 61 00 00       	call   80106d40 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 9e 3a 00 00       	call   801046d0 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 8b 3a 00 00       	call   801046d0 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 5a 62 00 00       	call   80106eb0 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 f0 61 00 00       	call   80106eb0 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 8b 39 00 00       	call   80104690 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 6f 5b 00 00       	call   801068a0 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 e7 5e 00 00       	call   80106c20 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 ed 6f 10 80       	push   $0x80106fed
80100d5b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d60:	e8 cb 34 00 00       	call   80104230 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d81:	e8 0a 36 00 00       	call   80104390 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dac:	68 c0 ff 10 80       	push   $0x8010ffc0
80100db1:	e8 8a 36 00 00       	call   80104440 <release>
      return f;
80100db6:	89 d8                	mov    %ebx,%eax
80100db8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc8:	e8 73 36 00 00       	call   80104440 <release>
  return 0;
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	31 c0                	xor    %eax,%eax
}
80100dd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd5:	c9                   	leave  
80100dd6:	c3                   	ret    
80100dd7:	89 f6                	mov    %esi,%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 c0 ff 10 80       	push   $0x8010ffc0
80100def:	e8 9c 35 00 00       	call   80104390 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0c:	e8 2f 36 00 00       	call   80104440 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 f4 6f 10 80       	push   $0x80106ff4
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 4a 35 00 00       	call   80104390 <acquire>
  if(f->ref < 1)
80100e46:	8b 47 04             	mov    0x4(%edi),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 47 04             	mov    %eax,0x4(%edi)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
    release(&ftable.lock);
80100e5e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e6c:	e9 cf 35 00 00       	jmp    80104440 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e78:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e7c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e81:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e84:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e90:	68 c0 ff 10 80       	push   $0x8010ffc0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e98:	e8 a3 35 00 00       	call   80104440 <release>

  if(ff.type == FD_PIPE)
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 fb 01             	cmp    $0x1,%ebx
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ea5:	83 fb 02             	cmp    $0x2,%ebx
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 1a 24 00 00       	call   801032e0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 6b 1c 00 00       	call   80102b40 <begin_op>
    iput(ff.ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 b0 08 00 00       	call   80101790 <iput>
    end_op();
80100ee0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eea:	e9 c1 1c 00 00       	jmp    80102bb0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 fc 6f 10 80       	push   $0x80106ffc
80100ef7:	e8 74 f4 ff ff       	call   80100370 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 46 07 00 00       	call   80101660 <ilock>
    stati(f->ip, st);
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 e9 09 00 00       	call   80101910 <stati>
    iunlock(f->ip);
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 10 08 00 00       	call   80101740 <iunlock>
    return 0;
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
    ilock(f->ip);
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 e1 06 00 00       	call   80101660 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 b4 09 00 00       	call   80101940 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
      f->off += r;
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 9d 07 00 00       	call   80101740 <iunlock>
    return r;
80100fa3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fa6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fbd:	e9 be 24 00 00       	jmp    80103480 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fcd:	eb d9                	jmp    80100fa8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 06 70 10 80       	push   $0x80107006
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d8 00 00 00    	jne    801010ee <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 ff                	xor    %edi,%edi
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101028:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101034:	e8 07 07 00 00       	call   80101740 <iunlock>
      end_op();
80101039:	e8 72 1b 00 00       	call   80102bb0 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101044:	39 d8                	cmp    %ebx,%eax
80101046:	0f 85 95 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010104c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 06 00 00       	mov    $0x600,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101066:	e8 d5 1a 00 00       	call   80102b40 <begin_op>
      ilock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 ea 05 00 00       	call   80101660 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 b8 09 00 00       	call   80101a40 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 a3 06 00 00       	call   80101740 <iunlock>
      end_op();
8010109d:	e8 0e 1b 00 00       	call   80102bb0 <end_op>

      if(r < 0)
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010b4:	5b                   	pop    %ebx
801010b5:	5e                   	pop    %esi
801010b6:	5f                   	pop    %edi
801010b7:	5d                   	pop    %ebp
801010b8:	c3                   	ret    
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
  }
  panic("filewrite");
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 46 0c             	mov    0xc(%esi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 9f 22 00 00       	jmp    80103380 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 0f 70 10 80       	push   $0x8010700f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 15 70 10 80       	push   $0x80107015
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	56                   	push   %esi
80101104:	53                   	push   %ebx
80101105:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101107:	c1 ea 0c             	shr    $0xc,%edx
8010110a:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101110:	83 ec 08             	sub    $0x8,%esp
80101113:	52                   	push   %edx
80101114:	50                   	push   %eax
80101115:	e8 b6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010111a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010111c:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101122:	ba 01 00 00 00       	mov    $0x1,%edx
80101127:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112a:	c1 fb 03             	sar    $0x3,%ebx
8010112d:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101130:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101132:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101137:	85 d1                	test   %edx,%ecx
80101139:	74 27                	je     80101162 <bfree+0x62>
8010113b:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010113d:	f7 d2                	not    %edx
8010113f:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101141:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101144:	21 d0                	and    %edx,%eax
80101146:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010114a:	56                   	push   %esi
8010114b:	e8 d0 1b 00 00       	call   80102d20 <log_write>
  brelse(bp);
80101150:	89 34 24             	mov    %esi,(%esp)
80101153:	e8 88 f0 ff ff       	call   801001e0 <brelse>
}
80101158:	83 c4 10             	add    $0x10,%esp
8010115b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010115e:	5b                   	pop    %ebx
8010115f:	5e                   	pop    %esi
80101160:	5d                   	pop    %ebp
80101161:	c3                   	ret    

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101162:	83 ec 0c             	sub    $0xc,%esp
80101165:	68 1f 70 10 80       	push   $0x8010701f
8010116a:	e8 01 f2 ff ff       	call   80100370 <panic>
8010116f:	90                   	nop

80101170 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101179:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010117f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101182:	85 c9                	test   %ecx,%ecx
80101184:	0f 84 85 00 00 00    	je     8010120f <balloc+0x9f>
8010118a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101191:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101194:	83 ec 08             	sub    $0x8,%esp
80101197:	89 f0                	mov    %esi,%eax
80101199:	c1 f8 0c             	sar    $0xc,%eax
8010119c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011a2:	50                   	push   %eax
801011a3:	ff 75 d8             	pushl  -0x28(%ebp)
801011a6:	e8 25 ef ff ff       	call   801000d0 <bread>
801011ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801011ae:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011b9:	31 c0                	xor    %eax,%eax
801011bb:	eb 2d                	jmp    801011ea <balloc+0x7a>
801011bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011c0:	89 c1                	mov    %eax,%ecx
801011c2:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011c7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801011ca:	83 e1 07             	and    $0x7,%ecx
801011cd:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011cf:	89 c1                	mov    %eax,%ecx
801011d1:	c1 f9 03             	sar    $0x3,%ecx
801011d4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801011d9:	85 d7                	test   %edx,%edi
801011db:	74 43                	je     80101220 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011dd:	83 c0 01             	add    $0x1,%eax
801011e0:	83 c6 01             	add    $0x1,%esi
801011e3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011e8:	74 05                	je     801011ef <balloc+0x7f>
801011ea:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011ed:	72 d1                	jb     801011c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	ff 75 e4             	pushl  -0x1c(%ebp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011fa:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101201:	83 c4 10             	add    $0x10,%esp
80101204:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101207:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010120d:	77 82                	ja     80101191 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010120f:	83 ec 0c             	sub    $0xc,%esp
80101212:	68 32 70 10 80       	push   $0x80107032
80101217:	e8 54 f1 ff ff       	call   80100370 <panic>
8010121c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101220:	09 fa                	or     %edi,%edx
80101222:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101225:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101228:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010122c:	57                   	push   %edi
8010122d:	e8 ee 1a 00 00       	call   80102d20 <log_write>
        brelse(bp);
80101232:	89 3c 24             	mov    %edi,(%esp)
80101235:	e8 a6 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010123a:	58                   	pop    %eax
8010123b:	5a                   	pop    %edx
8010123c:	56                   	push   %esi
8010123d:	ff 75 d8             	pushl  -0x28(%ebp)
80101240:	e8 8b ee ff ff       	call   801000d0 <bread>
80101245:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101247:	8d 40 5c             	lea    0x5c(%eax),%eax
8010124a:	83 c4 0c             	add    $0xc,%esp
8010124d:	68 00 02 00 00       	push   $0x200
80101252:	6a 00                	push   $0x0
80101254:	50                   	push   %eax
80101255:	e8 36 32 00 00       	call   80104490 <memset>
  log_write(bp);
8010125a:	89 1c 24             	mov    %ebx,(%esp)
8010125d:	e8 be 1a 00 00       	call   80102d20 <log_write>
  brelse(bp);
80101262:	89 1c 24             	mov    %ebx,(%esp)
80101265:	e8 76 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	89 f0                	mov    %esi,%eax
8010126f:	5b                   	pop    %ebx
80101270:	5e                   	pop    %esi
80101271:	5f                   	pop    %edi
80101272:	5d                   	pop    %ebp
80101273:	c3                   	ret    
80101274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010127a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101280 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101288:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010128f:	83 ec 28             	sub    $0x28,%esp
80101292:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101295:	68 e0 09 11 80       	push   $0x801109e0
8010129a:	e8 f1 30 00 00       	call   80104390 <acquire>
8010129f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012a5:	eb 1b                	jmp    801012c2 <iget+0x42>
801012a7:	89 f6                	mov    %esi,%esi
801012a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012b0:	85 f6                	test   %esi,%esi
801012b2:	74 44                	je     801012f8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012ba:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012c0:	74 4e                	je     80101310 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012c2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012c5:	85 c9                	test   %ecx,%ecx
801012c7:	7e e7                	jle    801012b0 <iget+0x30>
801012c9:	39 3b                	cmp    %edi,(%ebx)
801012cb:	75 e3                	jne    801012b0 <iget+0x30>
801012cd:	39 53 04             	cmp    %edx,0x4(%ebx)
801012d0:	75 de                	jne    801012b0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
801012d2:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012d5:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801012d8:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801012da:	68 e0 09 11 80       	push   $0x801109e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 59 31 00 00       	call   80104440 <release>
      return ip;
801012e7:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	89 f0                	mov    %esi,%eax
801012ef:	5b                   	pop    %ebx
801012f0:	5e                   	pop    %esi
801012f1:	5f                   	pop    %edi
801012f2:	5d                   	pop    %ebp
801012f3:	c3                   	ret    
801012f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012f8:	85 c9                	test   %ecx,%ecx
801012fa:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fd:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101303:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101309:	75 b7                	jne    801012c2 <iget+0x42>
8010130b:	90                   	nop
8010130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101310:	85 f6                	test   %esi,%esi
80101312:	74 2d                	je     80101341 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101314:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101317:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101319:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010131c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101323:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010132a:	68 e0 09 11 80       	push   $0x801109e0
8010132f:	e8 0c 31 00 00       	call   80104440 <release>

  return ip;
80101334:	83 c4 10             	add    $0x10,%esp
}
80101337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133a:	89 f0                	mov    %esi,%eax
8010133c:	5b                   	pop    %ebx
8010133d:	5e                   	pop    %esi
8010133e:	5f                   	pop    %edi
8010133f:	5d                   	pop    %ebp
80101340:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101341:	83 ec 0c             	sub    $0xc,%esp
80101344:	68 48 70 10 80       	push   $0x80107048
80101349:	e8 22 f0 ff ff       	call   80100370 <panic>
8010134e:	66 90                	xchg   %ax,%ax

80101350 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	89 c6                	mov    %eax,%esi
80101358:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010135b:	83 fa 0b             	cmp    $0xb,%edx
8010135e:	77 18                	ja     80101378 <bmap+0x28>
80101360:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101363:	8b 43 5c             	mov    0x5c(%ebx),%eax
80101366:	85 c0                	test   %eax,%eax
80101368:	74 76                	je     801013e0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	5b                   	pop    %ebx
8010136e:	5e                   	pop    %esi
8010136f:	5f                   	pop    %edi
80101370:	5d                   	pop    %ebp
80101371:	c3                   	ret    
80101372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101378:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010137b:	83 fb 7f             	cmp    $0x7f,%ebx
8010137e:	0f 87 83 00 00 00    	ja     80101407 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101384:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010138a:	85 c0                	test   %eax,%eax
8010138c:	74 6a                	je     801013f8 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010138e:	83 ec 08             	sub    $0x8,%esp
80101391:	50                   	push   %eax
80101392:	ff 36                	pushl  (%esi)
80101394:	e8 37 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101399:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010139d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013a0:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013a2:	8b 1a                	mov    (%edx),%ebx
801013a4:	85 db                	test   %ebx,%ebx
801013a6:	75 1d                	jne    801013c5 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
801013a8:	8b 06                	mov    (%esi),%eax
801013aa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013ad:	e8 be fd ff ff       	call   80101170 <balloc>
801013b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
801013b8:	89 c3                	mov    %eax,%ebx
801013ba:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013bc:	57                   	push   %edi
801013bd:	e8 5e 19 00 00       	call   80102d20 <log_write>
801013c2:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801013c5:	83 ec 0c             	sub    $0xc,%esp
801013c8:	57                   	push   %edi
801013c9:	e8 12 ee ff ff       	call   801001e0 <brelse>
801013ce:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801013d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013d4:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801013d6:	5b                   	pop    %ebx
801013d7:	5e                   	pop    %esi
801013d8:	5f                   	pop    %edi
801013d9:	5d                   	pop    %ebp
801013da:	c3                   	ret    
801013db:	90                   	nop
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 06                	mov    (%esi),%eax
801013e2:	e8 89 fd ff ff       	call   80101170 <balloc>
801013e7:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ed:	5b                   	pop    %ebx
801013ee:	5e                   	pop    %esi
801013ef:	5f                   	pop    %edi
801013f0:	5d                   	pop    %ebp
801013f1:	c3                   	ret    
801013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013f8:	8b 06                	mov    (%esi),%eax
801013fa:	e8 71 fd ff ff       	call   80101170 <balloc>
801013ff:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101405:	eb 87                	jmp    8010138e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101407:	83 ec 0c             	sub    $0xc,%esp
8010140a:	68 58 70 10 80       	push   $0x80107058
8010140f:	e8 5c ef ff ff       	call   80100370 <panic>
80101414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010141a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101420 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101428:	83 ec 08             	sub    $0x8,%esp
8010142b:	6a 01                	push   $0x1
8010142d:	ff 75 08             	pushl  0x8(%ebp)
80101430:	e8 9b ec ff ff       	call   801000d0 <bread>
80101435:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101437:	8d 40 5c             	lea    0x5c(%eax),%eax
8010143a:	83 c4 0c             	add    $0xc,%esp
8010143d:	6a 1c                	push   $0x1c
8010143f:	50                   	push   %eax
80101440:	56                   	push   %esi
80101441:	e8 fa 30 00 00       	call   80104540 <memmove>
  brelse(bp);
80101446:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101449:	83 c4 10             	add    $0x10,%esp
}
8010144c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010144f:	5b                   	pop    %ebx
80101450:	5e                   	pop    %esi
80101451:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101452:	e9 89 ed ff ff       	jmp    801001e0 <brelse>
80101457:	89 f6                	mov    %esi,%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101460 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	53                   	push   %ebx
80101464:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101469:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010146c:	68 6b 70 10 80       	push   $0x8010706b
80101471:	68 e0 09 11 80       	push   $0x801109e0
80101476:	e8 b5 2d 00 00       	call   80104230 <initlock>
8010147b:	83 c4 10             	add    $0x10,%esp
8010147e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	68 72 70 10 80       	push   $0x80107072
80101488:	53                   	push   %ebx
80101489:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148f:	e8 6c 2c 00 00       	call   80104100 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101494:	83 c4 10             	add    $0x10,%esp
80101497:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010149d:	75 e1                	jne    80101480 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010149f:	83 ec 08             	sub    $0x8,%esp
801014a2:	68 c0 09 11 80       	push   $0x801109c0
801014a7:	ff 75 08             	pushl  0x8(%ebp)
801014aa:	e8 71 ff ff ff       	call   80101420 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014af:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014b5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014bb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014c1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014c7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014cd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014d3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014d9:	68 d8 70 10 80       	push   $0x801070d8
801014de:	e8 7d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014e3:	83 c4 30             	add    $0x30,%esp
801014e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014e9:	c9                   	leave  
801014ea:	c3                   	ret    
801014eb:	90                   	nop
801014ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014f0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014f9:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101500:	8b 45 0c             	mov    0xc(%ebp),%eax
80101503:	8b 75 08             	mov    0x8(%ebp),%esi
80101506:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	0f 86 91 00 00 00    	jbe    801015a0 <ialloc+0xb0>
8010150f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101514:	eb 21                	jmp    80101537 <ialloc+0x47>
80101516:	8d 76 00             	lea    0x0(%esi),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101523:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101526:	57                   	push   %edi
80101527:	e8 b4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 c4 10             	add    $0x10,%esp
8010152f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101535:	76 69                	jbe    801015a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101537:	89 d8                	mov    %ebx,%eax
80101539:	83 ec 08             	sub    $0x8,%esp
8010153c:	c1 e8 03             	shr    $0x3,%eax
8010153f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101545:	50                   	push   %eax
80101546:	56                   	push   %esi
80101547:	e8 84 eb ff ff       	call   801000d0 <bread>
8010154c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010154e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101550:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101553:	83 e0 07             	and    $0x7,%eax
80101556:	c1 e0 06             	shl    $0x6,%eax
80101559:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010155d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101561:	75 bd                	jne    80101520 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101563:	83 ec 04             	sub    $0x4,%esp
80101566:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101569:	6a 40                	push   $0x40
8010156b:	6a 00                	push   $0x0
8010156d:	51                   	push   %ecx
8010156e:	e8 1d 2f 00 00       	call   80104490 <memset>
      dip->type = type;
80101573:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101577:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010157a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010157d:	89 3c 24             	mov    %edi,(%esp)
80101580:	e8 9b 17 00 00       	call   80102d20 <log_write>
      brelse(bp);
80101585:	89 3c 24             	mov    %edi,(%esp)
80101588:	e8 53 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010158d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101590:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101593:	89 da                	mov    %ebx,%edx
80101595:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101597:	5b                   	pop    %ebx
80101598:	5e                   	pop    %esi
80101599:	5f                   	pop    %edi
8010159a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010159b:	e9 e0 fc ff ff       	jmp    80101280 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015a0:	83 ec 0c             	sub    $0xc,%esp
801015a3:	68 78 70 10 80       	push   $0x80107078
801015a8:	e8 c3 ed ff ff       	call   80100370 <panic>
801015ad:	8d 76 00             	lea    0x0(%esi),%esi

801015b0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015b8:	83 ec 08             	sub    $0x8,%esp
801015bb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015be:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c1:	c1 e8 03             	shr    $0x3,%eax
801015c4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015ca:	50                   	push   %eax
801015cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ce:	e8 fd ea ff ff       	call   801000d0 <bread>
801015d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015dc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015df:	83 e0 07             	and    $0x7,%eax
801015e2:	c1 e0 06             	shl    $0x6,%eax
801015e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015f0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801015f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101603:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101607:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010160a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160d:	6a 34                	push   $0x34
8010160f:	53                   	push   %ebx
80101610:	50                   	push   %eax
80101611:	e8 2a 2f 00 00       	call   80104540 <memmove>
  log_write(bp);
80101616:	89 34 24             	mov    %esi,(%esp)
80101619:	e8 02 17 00 00       	call   80102d20 <log_write>
  brelse(bp);
8010161e:	89 75 08             	mov    %esi,0x8(%ebp)
80101621:	83 c4 10             	add    $0x10,%esp
}
80101624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101627:	5b                   	pop    %ebx
80101628:	5e                   	pop    %esi
80101629:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010162a:	e9 b1 eb ff ff       	jmp    801001e0 <brelse>
8010162f:	90                   	nop

80101630 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	83 ec 10             	sub    $0x10,%esp
80101637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010163a:	68 e0 09 11 80       	push   $0x801109e0
8010163f:	e8 4c 2d 00 00       	call   80104390 <acquire>
  ip->ref++;
80101644:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101648:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010164f:	e8 ec 2d 00 00       	call   80104440 <release>
  return ip;
}
80101654:	89 d8                	mov    %ebx,%eax
80101656:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101659:	c9                   	leave  
8010165a:	c3                   	ret    
8010165b:	90                   	nop
8010165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101660 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101668:	85 db                	test   %ebx,%ebx
8010166a:	0f 84 b7 00 00 00    	je     80101727 <ilock+0xc7>
80101670:	8b 53 08             	mov    0x8(%ebx),%edx
80101673:	85 d2                	test   %edx,%edx
80101675:	0f 8e ac 00 00 00    	jle    80101727 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010167b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010167e:	83 ec 0c             	sub    $0xc,%esp
80101681:	50                   	push   %eax
80101682:	e8 b9 2a 00 00       	call   80104140 <acquiresleep>

  if(ip->valid == 0){
80101687:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010168a:	83 c4 10             	add    $0x10,%esp
8010168d:	85 c0                	test   %eax,%eax
8010168f:	74 0f                	je     801016a0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101691:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101694:	5b                   	pop    %ebx
80101695:	5e                   	pop    %esi
80101696:	5d                   	pop    %ebp
80101697:	c3                   	ret    
80101698:	90                   	nop
80101699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a0:	8b 43 04             	mov    0x4(%ebx),%eax
801016a3:	83 ec 08             	sub    $0x8,%esp
801016a6:	c1 e8 03             	shr    $0x3,%eax
801016a9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016af:	50                   	push   %eax
801016b0:	ff 33                	pushl  (%ebx)
801016b2:	e8 19 ea ff ff       	call   801000d0 <bread>
801016b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016b9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016bc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016bf:	83 e0 07             	and    $0x7,%eax
801016c2:	c1 e0 06             	shl    $0x6,%eax
801016c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016c9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016f1:	6a 34                	push   $0x34
801016f3:	50                   	push   %eax
801016f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016f7:	50                   	push   %eax
801016f8:	e8 43 2e 00 00       	call   80104540 <memmove>
    brelse(bp);
801016fd:	89 34 24             	mov    %esi,(%esp)
80101700:	e8 db ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101705:	83 c4 10             	add    $0x10,%esp
80101708:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010170d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101714:	0f 85 77 ff ff ff    	jne    80101691 <ilock+0x31>
      panic("ilock: no type");
8010171a:	83 ec 0c             	sub    $0xc,%esp
8010171d:	68 90 70 10 80       	push   $0x80107090
80101722:	e8 49 ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101727:	83 ec 0c             	sub    $0xc,%esp
8010172a:	68 8a 70 10 80       	push   $0x8010708a
8010172f:	e8 3c ec ff ff       	call   80100370 <panic>
80101734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010173a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101740 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101748:	85 db                	test   %ebx,%ebx
8010174a:	74 28                	je     80101774 <iunlock+0x34>
8010174c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010174f:	83 ec 0c             	sub    $0xc,%esp
80101752:	56                   	push   %esi
80101753:	e8 88 2a 00 00       	call   801041e0 <holdingsleep>
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	85 c0                	test   %eax,%eax
8010175d:	74 15                	je     80101774 <iunlock+0x34>
8010175f:	8b 43 08             	mov    0x8(%ebx),%eax
80101762:	85 c0                	test   %eax,%eax
80101764:	7e 0e                	jle    80101774 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101766:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101769:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010176c:	5b                   	pop    %ebx
8010176d:	5e                   	pop    %esi
8010176e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010176f:	e9 2c 2a 00 00       	jmp    801041a0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101774:	83 ec 0c             	sub    $0xc,%esp
80101777:	68 9f 70 10 80       	push   $0x8010709f
8010177c:	e8 ef eb ff ff       	call   80100370 <panic>
80101781:	eb 0d                	jmp    80101790 <iput>
80101783:	90                   	nop
80101784:	90                   	nop
80101785:	90                   	nop
80101786:	90                   	nop
80101787:	90                   	nop
80101788:	90                   	nop
80101789:	90                   	nop
8010178a:	90                   	nop
8010178b:	90                   	nop
8010178c:	90                   	nop
8010178d:	90                   	nop
8010178e:	90                   	nop
8010178f:	90                   	nop

80101790 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010179c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010179f:	57                   	push   %edi
801017a0:	e8 9b 29 00 00       	call   80104140 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017a5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017a8:	83 c4 10             	add    $0x10,%esp
801017ab:	85 d2                	test   %edx,%edx
801017ad:	74 07                	je     801017b6 <iput+0x26>
801017af:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017b4:	74 32                	je     801017e8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801017b6:	83 ec 0c             	sub    $0xc,%esp
801017b9:	57                   	push   %edi
801017ba:	e8 e1 29 00 00       	call   801041a0 <releasesleep>

  acquire(&icache.lock);
801017bf:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017c6:	e8 c5 2b 00 00       	call   80104390 <acquire>
  ip->ref--;
801017cb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017cf:	83 c4 10             	add    $0x10,%esp
801017d2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801017d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017dc:	5b                   	pop    %ebx
801017dd:	5e                   	pop    %esi
801017de:	5f                   	pop    %edi
801017df:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801017e0:	e9 5b 2c 00 00       	jmp    80104440 <release>
801017e5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801017e8:	83 ec 0c             	sub    $0xc,%esp
801017eb:	68 e0 09 11 80       	push   $0x801109e0
801017f0:	e8 9b 2b 00 00       	call   80104390 <acquire>
    int r = ip->ref;
801017f5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801017f8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017ff:	e8 3c 2c 00 00       	call   80104440 <release>
    if(r == 1){
80101804:	83 c4 10             	add    $0x10,%esp
80101807:	83 fb 01             	cmp    $0x1,%ebx
8010180a:	75 aa                	jne    801017b6 <iput+0x26>
8010180c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101812:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101815:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101818:	89 cf                	mov    %ecx,%edi
8010181a:	eb 0b                	jmp    80101827 <iput+0x97>
8010181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101820:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101823:	39 fb                	cmp    %edi,%ebx
80101825:	74 19                	je     80101840 <iput+0xb0>
    if(ip->addrs[i]){
80101827:	8b 13                	mov    (%ebx),%edx
80101829:	85 d2                	test   %edx,%edx
8010182b:	74 f3                	je     80101820 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010182d:	8b 06                	mov    (%esi),%eax
8010182f:	e8 cc f8 ff ff       	call   80101100 <bfree>
      ip->addrs[i] = 0;
80101834:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010183a:	eb e4                	jmp    80101820 <iput+0x90>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101840:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101846:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101849:	85 c0                	test   %eax,%eax
8010184b:	75 33                	jne    80101880 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010184d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101850:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101857:	56                   	push   %esi
80101858:	e8 53 fd ff ff       	call   801015b0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010185d:	31 c0                	xor    %eax,%eax
8010185f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101863:	89 34 24             	mov    %esi,(%esp)
80101866:	e8 45 fd ff ff       	call   801015b0 <iupdate>
      ip->valid = 0;
8010186b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101872:	83 c4 10             	add    $0x10,%esp
80101875:	e9 3c ff ff ff       	jmp    801017b6 <iput+0x26>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101880:	83 ec 08             	sub    $0x8,%esp
80101883:	50                   	push   %eax
80101884:	ff 36                	pushl  (%esi)
80101886:	e8 45 e8 ff ff       	call   801000d0 <bread>
8010188b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101891:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101894:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101897:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010189a:	83 c4 10             	add    $0x10,%esp
8010189d:	89 cf                	mov    %ecx,%edi
8010189f:	eb 0e                	jmp    801018af <iput+0x11f>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018ab:	39 fb                	cmp    %edi,%ebx
801018ad:	74 0f                	je     801018be <iput+0x12e>
      if(a[j])
801018af:	8b 13                	mov    (%ebx),%edx
801018b1:	85 d2                	test   %edx,%edx
801018b3:	74 f3                	je     801018a8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018b5:	8b 06                	mov    (%esi),%eax
801018b7:	e8 44 f8 ff ff       	call   80101100 <bfree>
801018bc:	eb ea                	jmp    801018a8 <iput+0x118>
    }
    brelse(bp);
801018be:	83 ec 0c             	sub    $0xc,%esp
801018c1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018c7:	e8 14 e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018cc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018d2:	8b 06                	mov    (%esi),%eax
801018d4:	e8 27 f8 ff ff       	call   80101100 <bfree>
    ip->addrs[NDIRECT] = 0;
801018d9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018e0:	00 00 00 
801018e3:	83 c4 10             	add    $0x10,%esp
801018e6:	e9 62 ff ff ff       	jmp    8010184d <iput+0xbd>
801018eb:	90                   	nop
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018f0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	53                   	push   %ebx
801018f4:	83 ec 10             	sub    $0x10,%esp
801018f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018fa:	53                   	push   %ebx
801018fb:	e8 40 fe ff ff       	call   80101740 <iunlock>
  iput(ip);
80101900:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101903:	83 c4 10             	add    $0x10,%esp
}
80101906:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101909:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010190a:	e9 81 fe ff ff       	jmp    80101790 <iput>
8010190f:	90                   	nop

80101910 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	8b 55 08             	mov    0x8(%ebp),%edx
80101916:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101919:	8b 0a                	mov    (%edx),%ecx
8010191b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010191e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101921:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101924:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101928:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010192b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010192f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101933:	8b 52 58             	mov    0x58(%edx),%edx
80101936:	89 50 10             	mov    %edx,0x10(%eax)
}
80101939:	5d                   	pop    %ebp
8010193a:	c3                   	ret    
8010193b:	90                   	nop
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101940 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	57                   	push   %edi
80101944:	56                   	push   %esi
80101945:	53                   	push   %ebx
80101946:	83 ec 1c             	sub    $0x1c,%esp
80101949:	8b 45 08             	mov    0x8(%ebp),%eax
8010194c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010194f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101952:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101957:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010195a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010195d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101960:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101963:	0f 84 a7 00 00 00    	je     80101a10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101969:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010196c:	8b 40 58             	mov    0x58(%eax),%eax
8010196f:	39 f0                	cmp    %esi,%eax
80101971:	0f 82 c1 00 00 00    	jb     80101a38 <readi+0xf8>
80101977:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010197a:	89 fa                	mov    %edi,%edx
8010197c:	01 f2                	add    %esi,%edx
8010197e:	0f 82 b4 00 00 00    	jb     80101a38 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101984:	89 c1                	mov    %eax,%ecx
80101986:	29 f1                	sub    %esi,%ecx
80101988:	39 d0                	cmp    %edx,%eax
8010198a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010198d:	31 ff                	xor    %edi,%edi
8010198f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101991:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101994:	74 6d                	je     80101a03 <readi+0xc3>
80101996:	8d 76 00             	lea    0x0(%esi),%esi
80101999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019a3:	89 f2                	mov    %esi,%edx
801019a5:	c1 ea 09             	shr    $0x9,%edx
801019a8:	89 d8                	mov    %ebx,%eax
801019aa:	e8 a1 f9 ff ff       	call   80101350 <bmap>
801019af:	83 ec 08             	sub    $0x8,%esp
801019b2:	50                   	push   %eax
801019b3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
801019b5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ba:	e8 11 e7 ff ff       	call   801000d0 <bread>
801019bf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019c4:	89 f1                	mov    %esi,%ecx
801019c6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019cc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801019cf:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019d2:	29 cb                	sub    %ecx,%ebx
801019d4:	29 f8                	sub    %edi,%eax
801019d6:	39 c3                	cmp    %eax,%ebx
801019d8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019db:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019df:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e0:	01 df                	add    %ebx,%edi
801019e2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019e4:	50                   	push   %eax
801019e5:	ff 75 e0             	pushl  -0x20(%ebp)
801019e8:	e8 53 2b 00 00       	call   80104540 <memmove>
    brelse(bp);
801019ed:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019f0:	89 14 24             	mov    %edx,(%esp)
801019f3:	e8 e8 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019fb:	83 c4 10             	add    $0x10,%esp
801019fe:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a01:	77 9d                	ja     801019a0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a09:	5b                   	pop    %ebx
80101a0a:	5e                   	pop    %esi
80101a0b:	5f                   	pop    %edi
80101a0c:	5d                   	pop    %ebp
80101a0d:	c3                   	ret    
80101a0e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a14:	66 83 f8 09          	cmp    $0x9,%ax
80101a18:	77 1e                	ja     80101a38 <readi+0xf8>
80101a1a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a21:	85 c0                	test   %eax,%eax
80101a23:	74 13                	je     80101a38 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a25:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a2b:	5b                   	pop    %ebx
80101a2c:	5e                   	pop    %esi
80101a2d:	5f                   	pop    %edi
80101a2e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a2f:	ff e0                	jmp    *%eax
80101a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a3d:	eb c7                	jmp    80101a06 <readi+0xc6>
80101a3f:	90                   	nop

80101a40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 1c             	sub    $0x1c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a60:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a63:	0f 84 b7 00 00 00    	je     80101b20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a6f:	0f 82 eb 00 00 00    	jb     80101b60 <writei+0x120>
80101a75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a78:	89 f8                	mov    %edi,%eax
80101a7a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a7c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a81:	0f 87 d9 00 00 00    	ja     80101b60 <writei+0x120>
80101a87:	39 c6                	cmp    %eax,%esi
80101a89:	0f 87 d1 00 00 00    	ja     80101b60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a8f:	85 ff                	test   %edi,%edi
80101a91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a98:	74 78                	je     80101b12 <writei+0xd2>
80101a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101aa3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aaa:	c1 ea 09             	shr    $0x9,%edx
80101aad:	89 f8                	mov    %edi,%eax
80101aaf:	e8 9c f8 ff ff       	call   80101350 <bmap>
80101ab4:	83 ec 08             	sub    $0x8,%esp
80101ab7:	50                   	push   %eax
80101ab8:	ff 37                	pushl  (%edi)
80101aba:	e8 11 e6 ff ff       	call   801000d0 <bread>
80101abf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ac4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ac7:	89 f1                	mov    %esi,%ecx
80101ac9:	83 c4 0c             	add    $0xc,%esp
80101acc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ad2:	29 cb                	sub    %ecx,%ebx
80101ad4:	39 c3                	cmp    %eax,%ebx
80101ad6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ad9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101add:	53                   	push   %ebx
80101ade:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ae1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ae3:	50                   	push   %eax
80101ae4:	e8 57 2a 00 00       	call   80104540 <memmove>
    log_write(bp);
80101ae9:	89 3c 24             	mov    %edi,(%esp)
80101aec:	e8 2f 12 00 00       	call   80102d20 <log_write>
    brelse(bp);
80101af1:	89 3c 24             	mov    %edi,(%esp)
80101af4:	e8 e7 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101afc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101aff:	83 c4 10             	add    $0x10,%esp
80101b02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b05:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b08:	77 96                	ja     80101aa0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b0d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b10:	77 36                	ja     80101b48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b18:	5b                   	pop    %ebx
80101b19:	5e                   	pop    %esi
80101b1a:	5f                   	pop    %edi
80101b1b:	5d                   	pop    %ebp
80101b1c:	c3                   	ret    
80101b1d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b24:	66 83 f8 09          	cmp    $0x9,%ax
80101b28:	77 36                	ja     80101b60 <writei+0x120>
80101b2a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b31:	85 c0                	test   %eax,%eax
80101b33:	74 2b                	je     80101b60 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b35:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3b:	5b                   	pop    %ebx
80101b3c:	5e                   	pop    %esi
80101b3d:	5f                   	pop    %edi
80101b3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b3f:	ff e0                	jmp    *%eax
80101b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b4b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b51:	50                   	push   %eax
80101b52:	e8 59 fa ff ff       	call   801015b0 <iupdate>
80101b57:	83 c4 10             	add    $0x10,%esp
80101b5a:	eb b6                	jmp    80101b12 <writei+0xd2>
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b65:	eb ae                	jmp    80101b15 <writei+0xd5>
80101b67:	89 f6                	mov    %esi,%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b76:	6a 0e                	push   $0xe
80101b78:	ff 75 0c             	pushl  0xc(%ebp)
80101b7b:	ff 75 08             	pushl  0x8(%ebp)
80101b7e:	e8 3d 2a 00 00       	call   801045c0 <strncmp>
}
80101b83:	c9                   	leave  
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ba1:	0f 85 80 00 00 00    	jne    80101c27 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ba7:	8b 53 58             	mov    0x58(%ebx),%edx
80101baa:	31 ff                	xor    %edi,%edi
80101bac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101baf:	85 d2                	test   %edx,%edx
80101bb1:	75 0d                	jne    80101bc0 <dirlookup+0x30>
80101bb3:	eb 5b                	jmp    80101c10 <dirlookup+0x80>
80101bb5:	8d 76 00             	lea    0x0(%esi),%esi
80101bb8:	83 c7 10             	add    $0x10,%edi
80101bbb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bbe:	76 50                	jbe    80101c10 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bc0:	6a 10                	push   $0x10
80101bc2:	57                   	push   %edi
80101bc3:	56                   	push   %esi
80101bc4:	53                   	push   %ebx
80101bc5:	e8 76 fd ff ff       	call   80101940 <readi>
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	83 f8 10             	cmp    $0x10,%eax
80101bd0:	75 48                	jne    80101c1a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101bd2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bd7:	74 df                	je     80101bb8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bd9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bdc:	83 ec 04             	sub    $0x4,%esp
80101bdf:	6a 0e                	push   $0xe
80101be1:	50                   	push   %eax
80101be2:	ff 75 0c             	pushl  0xc(%ebp)
80101be5:	e8 d6 29 00 00       	call   801045c0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bea:	83 c4 10             	add    $0x10,%esp
80101bed:	85 c0                	test   %eax,%eax
80101bef:	75 c7                	jne    80101bb8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101bf1:	8b 45 10             	mov    0x10(%ebp),%eax
80101bf4:	85 c0                	test   %eax,%eax
80101bf6:	74 05                	je     80101bfd <dirlookup+0x6d>
        *poff = off;
80101bf8:	8b 45 10             	mov    0x10(%ebp),%eax
80101bfb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101bfd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c01:	8b 03                	mov    (%ebx),%eax
80101c03:	e8 78 f6 ff ff       	call   80101280 <iget>
    }
  }

  return 0;
}
80101c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c0b:	5b                   	pop    %ebx
80101c0c:	5e                   	pop    %esi
80101c0d:	5f                   	pop    %edi
80101c0e:	5d                   	pop    %ebp
80101c0f:	c3                   	ret    
80101c10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c13:	31 c0                	xor    %eax,%eax
}
80101c15:	5b                   	pop    %ebx
80101c16:	5e                   	pop    %esi
80101c17:	5f                   	pop    %edi
80101c18:	5d                   	pop    %ebp
80101c19:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c1a:	83 ec 0c             	sub    $0xc,%esp
80101c1d:	68 b9 70 10 80       	push   $0x801070b9
80101c22:	e8 49 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c27:	83 ec 0c             	sub    $0xc,%esp
80101c2a:	68 a7 70 10 80       	push   $0x801070a7
80101c2f:	e8 3c e7 ff ff       	call   80100370 <panic>
80101c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	57                   	push   %edi
80101c44:	56                   	push   %esi
80101c45:	53                   	push   %ebx
80101c46:	89 cf                	mov    %ecx,%edi
80101c48:	89 c3                	mov    %eax,%ebx
80101c4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c4d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c53:	0f 84 53 01 00 00    	je     80101dac <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c59:	e8 12 1b 00 00       	call   80103770 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c5e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c61:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c64:	68 e0 09 11 80       	push   $0x801109e0
80101c69:	e8 22 27 00 00       	call   80104390 <acquire>
  ip->ref++;
80101c6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c72:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c79:	e8 c2 27 00 00       	call   80104440 <release>
80101c7e:	83 c4 10             	add    $0x10,%esp
80101c81:	eb 08                	jmp    80101c8b <namex+0x4b>
80101c83:	90                   	nop
80101c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c88:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c8b:	0f b6 03             	movzbl (%ebx),%eax
80101c8e:	3c 2f                	cmp    $0x2f,%al
80101c90:	74 f6                	je     80101c88 <namex+0x48>
    path++;
  if(*path == 0)
80101c92:	84 c0                	test   %al,%al
80101c94:	0f 84 e3 00 00 00    	je     80101d7d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c9a:	0f b6 03             	movzbl (%ebx),%eax
80101c9d:	89 da                	mov    %ebx,%edx
80101c9f:	84 c0                	test   %al,%al
80101ca1:	0f 84 ac 00 00 00    	je     80101d53 <namex+0x113>
80101ca7:	3c 2f                	cmp    $0x2f,%al
80101ca9:	75 09                	jne    80101cb4 <namex+0x74>
80101cab:	e9 a3 00 00 00       	jmp    80101d53 <namex+0x113>
80101cb0:	84 c0                	test   %al,%al
80101cb2:	74 0a                	je     80101cbe <namex+0x7e>
    path++;
80101cb4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cb7:	0f b6 02             	movzbl (%edx),%eax
80101cba:	3c 2f                	cmp    $0x2f,%al
80101cbc:	75 f2                	jne    80101cb0 <namex+0x70>
80101cbe:	89 d1                	mov    %edx,%ecx
80101cc0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cc2:	83 f9 0d             	cmp    $0xd,%ecx
80101cc5:	0f 8e 8d 00 00 00    	jle    80101d58 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101ccb:	83 ec 04             	sub    $0x4,%esp
80101cce:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cd1:	6a 0e                	push   $0xe
80101cd3:	53                   	push   %ebx
80101cd4:	57                   	push   %edi
80101cd5:	e8 66 28 00 00       	call   80104540 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101cdd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101ce0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ce2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ce5:	75 11                	jne    80101cf8 <namex+0xb8>
80101ce7:	89 f6                	mov    %esi,%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cf0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cf3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cf6:	74 f8                	je     80101cf0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cf8:	83 ec 0c             	sub    $0xc,%esp
80101cfb:	56                   	push   %esi
80101cfc:	e8 5f f9 ff ff       	call   80101660 <ilock>
    if(ip->type != T_DIR){
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d09:	0f 85 7f 00 00 00    	jne    80101d8e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d12:	85 d2                	test   %edx,%edx
80101d14:	74 09                	je     80101d1f <namex+0xdf>
80101d16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d19:	0f 84 a3 00 00 00    	je     80101dc2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d1f:	83 ec 04             	sub    $0x4,%esp
80101d22:	6a 00                	push   $0x0
80101d24:	57                   	push   %edi
80101d25:	56                   	push   %esi
80101d26:	e8 65 fe ff ff       	call   80101b90 <dirlookup>
80101d2b:	83 c4 10             	add    $0x10,%esp
80101d2e:	85 c0                	test   %eax,%eax
80101d30:	74 5c                	je     80101d8e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d32:	83 ec 0c             	sub    $0xc,%esp
80101d35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d38:	56                   	push   %esi
80101d39:	e8 02 fa ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d3e:	89 34 24             	mov    %esi,(%esp)
80101d41:	e8 4a fa ff ff       	call   80101790 <iput>
80101d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d49:	83 c4 10             	add    $0x10,%esp
80101d4c:	89 c6                	mov    %eax,%esi
80101d4e:	e9 38 ff ff ff       	jmp    80101c8b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d53:	31 c9                	xor    %ecx,%ecx
80101d55:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d58:	83 ec 04             	sub    $0x4,%esp
80101d5b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d5e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d61:	51                   	push   %ecx
80101d62:	53                   	push   %ebx
80101d63:	57                   	push   %edi
80101d64:	e8 d7 27 00 00       	call   80104540 <memmove>
    name[len] = 0;
80101d69:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d6f:	83 c4 10             	add    $0x10,%esp
80101d72:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d76:	89 d3                	mov    %edx,%ebx
80101d78:	e9 65 ff ff ff       	jmp    80101ce2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d80:	85 c0                	test   %eax,%eax
80101d82:	75 54                	jne    80101dd8 <namex+0x198>
80101d84:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d89:	5b                   	pop    %ebx
80101d8a:	5e                   	pop    %esi
80101d8b:	5f                   	pop    %edi
80101d8c:	5d                   	pop    %ebp
80101d8d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d8e:	83 ec 0c             	sub    $0xc,%esp
80101d91:	56                   	push   %esi
80101d92:	e8 a9 f9 ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d97:	89 34 24             	mov    %esi,(%esp)
80101d9a:	e8 f1 f9 ff ff       	call   80101790 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d9f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101da2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101da5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101da7:	5b                   	pop    %ebx
80101da8:	5e                   	pop    %esi
80101da9:	5f                   	pop    %edi
80101daa:	5d                   	pop    %ebp
80101dab:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101dac:	ba 01 00 00 00       	mov    $0x1,%edx
80101db1:	b8 01 00 00 00       	mov    $0x1,%eax
80101db6:	e8 c5 f4 ff ff       	call   80101280 <iget>
80101dbb:	89 c6                	mov    %eax,%esi
80101dbd:	e9 c9 fe ff ff       	jmp    80101c8b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101dc2:	83 ec 0c             	sub    $0xc,%esp
80101dc5:	56                   	push   %esi
80101dc6:	e8 75 f9 ff ff       	call   80101740 <iunlock>
      return ip;
80101dcb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101dd1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dd3:	5b                   	pop    %ebx
80101dd4:	5e                   	pop    %esi
80101dd5:	5f                   	pop    %edi
80101dd6:	5d                   	pop    %ebp
80101dd7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101dd8:	83 ec 0c             	sub    $0xc,%esp
80101ddb:	56                   	push   %esi
80101ddc:	e8 af f9 ff ff       	call   80101790 <iput>
    return 0;
80101de1:	83 c4 10             	add    $0x10,%esp
80101de4:	31 c0                	xor    %eax,%eax
80101de6:	eb 9e                	jmp    80101d86 <namex+0x146>
80101de8:	90                   	nop
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101df0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 20             	sub    $0x20,%esp
80101df9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101dfc:	6a 00                	push   $0x0
80101dfe:	ff 75 0c             	pushl  0xc(%ebp)
80101e01:	53                   	push   %ebx
80101e02:	e8 89 fd ff ff       	call   80101b90 <dirlookup>
80101e07:	83 c4 10             	add    $0x10,%esp
80101e0a:	85 c0                	test   %eax,%eax
80101e0c:	75 67                	jne    80101e75 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e14:	85 ff                	test   %edi,%edi
80101e16:	74 29                	je     80101e41 <dirlink+0x51>
80101e18:	31 ff                	xor    %edi,%edi
80101e1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e1d:	eb 09                	jmp    80101e28 <dirlink+0x38>
80101e1f:	90                   	nop
80101e20:	83 c7 10             	add    $0x10,%edi
80101e23:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e26:	76 19                	jbe    80101e41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e28:	6a 10                	push   $0x10
80101e2a:	57                   	push   %edi
80101e2b:	56                   	push   %esi
80101e2c:	53                   	push   %ebx
80101e2d:	e8 0e fb ff ff       	call   80101940 <readi>
80101e32:	83 c4 10             	add    $0x10,%esp
80101e35:	83 f8 10             	cmp    $0x10,%eax
80101e38:	75 4e                	jne    80101e88 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e3f:	75 df                	jne    80101e20 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e41:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e44:	83 ec 04             	sub    $0x4,%esp
80101e47:	6a 0e                	push   $0xe
80101e49:	ff 75 0c             	pushl  0xc(%ebp)
80101e4c:	50                   	push   %eax
80101e4d:	e8 de 27 00 00       	call   80104630 <strncpy>
  de.inum = inum;
80101e52:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e55:	6a 10                	push   $0x10
80101e57:	57                   	push   %edi
80101e58:	56                   	push   %esi
80101e59:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e5a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e5e:	e8 dd fb ff ff       	call   80101a40 <writei>
80101e63:	83 c4 20             	add    $0x20,%esp
80101e66:	83 f8 10             	cmp    $0x10,%eax
80101e69:	75 2a                	jne    80101e95 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e6b:	31 c0                	xor    %eax,%eax
}
80101e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e70:	5b                   	pop    %ebx
80101e71:	5e                   	pop    %esi
80101e72:	5f                   	pop    %edi
80101e73:	5d                   	pop    %ebp
80101e74:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	50                   	push   %eax
80101e79:	e8 12 f9 ff ff       	call   80101790 <iput>
    return -1;
80101e7e:	83 c4 10             	add    $0x10,%esp
80101e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e86:	eb e5                	jmp    80101e6d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e88:	83 ec 0c             	sub    $0xc,%esp
80101e8b:	68 c8 70 10 80       	push   $0x801070c8
80101e90:	e8 db e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e95:	83 ec 0c             	sub    $0xc,%esp
80101e98:	68 c2 76 10 80       	push   $0x801076c2
80101e9d:	e8 ce e4 ff ff       	call   80100370 <panic>
80101ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101eb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101eb1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101eb3:	89 e5                	mov    %esp,%ebp
80101eb5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101eb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ebe:	e8 7d fd ff ff       	call   80101c40 <namex>
}
80101ec3:	c9                   	leave  
80101ec4:	c3                   	ret    
80101ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ed0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ed0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ed1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ed6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ed8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101edb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ede:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101edf:	e9 5c fd ff ff       	jmp    80101c40 <namex>
80101ee4:	66 90                	xchg   %ax,%ax
80101ee6:	66 90                	xchg   %ax,%ax
80101ee8:	66 90                	xchg   %ax,%ax
80101eea:	66 90                	xchg   %ax,%ax
80101eec:	66 90                	xchg   %ax,%ax
80101eee:	66 90                	xchg   %ax,%ax

80101ef0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ef0:	55                   	push   %ebp
  if(b == 0)
80101ef1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ef3:	89 e5                	mov    %esp,%ebp
80101ef5:	56                   	push   %esi
80101ef6:	53                   	push   %ebx
  if(b == 0)
80101ef7:	0f 84 ad 00 00 00    	je     80101faa <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101efd:	8b 58 08             	mov    0x8(%eax),%ebx
80101f00:	89 c1                	mov    %eax,%ecx
80101f02:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f08:	0f 87 8f 00 00 00    	ja     80101f9d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f0e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f13:	90                   	nop
80101f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f18:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f19:	83 e0 c0             	and    $0xffffffc0,%eax
80101f1c:	3c 40                	cmp    $0x40,%al
80101f1e:	75 f8                	jne    80101f18 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f20:	31 f6                	xor    %esi,%esi
80101f22:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f27:	89 f0                	mov    %esi,%eax
80101f29:	ee                   	out    %al,(%dx)
80101f2a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f2f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f34:	ee                   	out    %al,(%dx)
80101f35:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f3a:	89 d8                	mov    %ebx,%eax
80101f3c:	ee                   	out    %al,(%dx)
80101f3d:	89 d8                	mov    %ebx,%eax
80101f3f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f44:	c1 f8 08             	sar    $0x8,%eax
80101f47:	ee                   	out    %al,(%dx)
80101f48:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f4d:	89 f0                	mov    %esi,%eax
80101f4f:	ee                   	out    %al,(%dx)
80101f50:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f54:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f59:	83 e0 01             	and    $0x1,%eax
80101f5c:	c1 e0 04             	shl    $0x4,%eax
80101f5f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f62:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f63:	f6 01 04             	testb  $0x4,(%ecx)
80101f66:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f6b:	75 13                	jne    80101f80 <idestart+0x90>
80101f6d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f72:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f76:	5b                   	pop    %ebx
80101f77:	5e                   	pop    %esi
80101f78:	5d                   	pop    %ebp
80101f79:	c3                   	ret    
80101f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f80:	b8 30 00 00 00       	mov    $0x30,%eax
80101f85:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f86:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f8b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f8e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f93:	fc                   	cld    
80101f94:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f99:	5b                   	pop    %ebx
80101f9a:	5e                   	pop    %esi
80101f9b:	5d                   	pop    %ebp
80101f9c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f9d:	83 ec 0c             	sub    $0xc,%esp
80101fa0:	68 34 71 10 80       	push   $0x80107134
80101fa5:	e8 c6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101faa:	83 ec 0c             	sub    $0xc,%esp
80101fad:	68 2b 71 10 80       	push   $0x8010712b
80101fb2:	e8 b9 e3 ff ff       	call   80100370 <panic>
80101fb7:	89 f6                	mov    %esi,%esi
80101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fc0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 e5                	mov    %esp,%ebp
80101fc3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fc6:	68 46 71 10 80       	push   $0x80107146
80101fcb:	68 80 a5 10 80       	push   $0x8010a580
80101fd0:	e8 5b 22 00 00       	call   80104230 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fd5:	58                   	pop    %eax
80101fd6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80101fdb:	5a                   	pop    %edx
80101fdc:	83 e8 01             	sub    $0x1,%eax
80101fdf:	50                   	push   %eax
80101fe0:	6a 0e                	push   $0xe
80101fe2:	e8 a9 02 00 00       	call   80102290 <ioapicenable>
80101fe7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fea:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fef:	90                   	nop
80101ff0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ff1:	83 e0 c0             	and    $0xffffffc0,%eax
80101ff4:	3c 40                	cmp    $0x40,%al
80101ff6:	75 f8                	jne    80101ff0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101ff8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ffd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102002:	ee                   	out    %al,(%dx)
80102003:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102008:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010200d:	eb 06                	jmp    80102015 <ideinit+0x55>
8010200f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102010:	83 e9 01             	sub    $0x1,%ecx
80102013:	74 0f                	je     80102024 <ideinit+0x64>
80102015:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102016:	84 c0                	test   %al,%al
80102018:	74 f6                	je     80102010 <ideinit+0x50>
      havedisk1 = 1;
8010201a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102021:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102024:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102029:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010202e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010202f:	c9                   	leave  
80102030:	c3                   	ret    
80102031:	eb 0d                	jmp    80102040 <ideintr>
80102033:	90                   	nop
80102034:	90                   	nop
80102035:	90                   	nop
80102036:	90                   	nop
80102037:	90                   	nop
80102038:	90                   	nop
80102039:	90                   	nop
8010203a:	90                   	nop
8010203b:	90                   	nop
8010203c:	90                   	nop
8010203d:	90                   	nop
8010203e:	90                   	nop
8010203f:	90                   	nop

80102040 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	53                   	push   %ebx
80102046:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102049:	68 80 a5 10 80       	push   $0x8010a580
8010204e:	e8 3d 23 00 00       	call   80104390 <acquire>

  if((b = idequeue) == 0){
80102053:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102059:	83 c4 10             	add    $0x10,%esp
8010205c:	85 db                	test   %ebx,%ebx
8010205e:	74 34                	je     80102094 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102060:	8b 43 58             	mov    0x58(%ebx),%eax
80102063:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102068:	8b 33                	mov    (%ebx),%esi
8010206a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102070:	74 3e                	je     801020b0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102072:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102075:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102078:	83 ce 02             	or     $0x2,%esi
8010207b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010207d:	53                   	push   %ebx
8010207e:	e8 5d 1e 00 00       	call   80103ee0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102083:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102088:	83 c4 10             	add    $0x10,%esp
8010208b:	85 c0                	test   %eax,%eax
8010208d:	74 05                	je     80102094 <ideintr+0x54>
    idestart(idequeue);
8010208f:	e8 5c fe ff ff       	call   80101ef0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	68 80 a5 10 80       	push   $0x8010a580
8010209c:	e8 9f 23 00 00       	call   80104440 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a4:	5b                   	pop    %ebx
801020a5:	5e                   	pop    %esi
801020a6:	5f                   	pop    %edi
801020a7:	5d                   	pop    %ebp
801020a8:	c3                   	ret    
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b5:	8d 76 00             	lea    0x0(%esi),%esi
801020b8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020b9:	89 c1                	mov    %eax,%ecx
801020bb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020be:	80 f9 40             	cmp    $0x40,%cl
801020c1:	75 f5                	jne    801020b8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020c3:	a8 21                	test   $0x21,%al
801020c5:	75 ab                	jne    80102072 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020c7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020ca:	b9 80 00 00 00       	mov    $0x80,%ecx
801020cf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020d4:	fc                   	cld    
801020d5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020d7:	8b 33                	mov    (%ebx),%esi
801020d9:	eb 97                	jmp    80102072 <ideintr+0x32>
801020db:	90                   	nop
801020dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	53                   	push   %ebx
801020e4:	83 ec 10             	sub    $0x10,%esp
801020e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801020ed:	50                   	push   %eax
801020ee:	e8 ed 20 00 00       	call   801041e0 <holdingsleep>
801020f3:	83 c4 10             	add    $0x10,%esp
801020f6:	85 c0                	test   %eax,%eax
801020f8:	0f 84 ad 00 00 00    	je     801021ab <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020fe:	8b 03                	mov    (%ebx),%eax
80102100:	83 e0 06             	and    $0x6,%eax
80102103:	83 f8 02             	cmp    $0x2,%eax
80102106:	0f 84 b9 00 00 00    	je     801021c5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010210c:	8b 53 04             	mov    0x4(%ebx),%edx
8010210f:	85 d2                	test   %edx,%edx
80102111:	74 0d                	je     80102120 <iderw+0x40>
80102113:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102118:	85 c0                	test   %eax,%eax
8010211a:	0f 84 98 00 00 00    	je     801021b8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102120:	83 ec 0c             	sub    $0xc,%esp
80102123:	68 80 a5 10 80       	push   $0x8010a580
80102128:	e8 63 22 00 00       	call   80104390 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010212d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102133:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102136:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	85 d2                	test   %edx,%edx
8010213f:	75 09                	jne    8010214a <iderw+0x6a>
80102141:	eb 58                	jmp    8010219b <iderw+0xbb>
80102143:	90                   	nop
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102148:	89 c2                	mov    %eax,%edx
8010214a:	8b 42 58             	mov    0x58(%edx),%eax
8010214d:	85 c0                	test   %eax,%eax
8010214f:	75 f7                	jne    80102148 <iderw+0x68>
80102151:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102154:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102156:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010215c:	74 44                	je     801021a2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	74 23                	je     8010218b <iderw+0xab>
80102168:	90                   	nop
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102170:	83 ec 08             	sub    $0x8,%esp
80102173:	68 80 a5 10 80       	push   $0x8010a580
80102178:	53                   	push   %ebx
80102179:	e8 b2 1b 00 00       	call   80103d30 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010217e:	8b 03                	mov    (%ebx),%eax
80102180:	83 c4 10             	add    $0x10,%esp
80102183:	83 e0 06             	and    $0x6,%eax
80102186:	83 f8 02             	cmp    $0x2,%eax
80102189:	75 e5                	jne    80102170 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010218b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102195:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102196:	e9 a5 22 00 00       	jmp    80104440 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021a0:	eb b2                	jmp    80102154 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021a2:	89 d8                	mov    %ebx,%eax
801021a4:	e8 47 fd ff ff       	call   80101ef0 <idestart>
801021a9:	eb b3                	jmp    8010215e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021ab:	83 ec 0c             	sub    $0xc,%esp
801021ae:	68 4a 71 10 80       	push   $0x8010714a
801021b3:	e8 b8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021b8:	83 ec 0c             	sub    $0xc,%esp
801021bb:	68 75 71 10 80       	push   $0x80107175
801021c0:	e8 ab e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	68 60 71 10 80       	push   $0x80107160
801021cd:	e8 9e e1 ff ff       	call   80100370 <panic>
801021d2:	66 90                	xchg   %ax,%ax
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021e1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801021e8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021eb:	89 e5                	mov    %esp,%ebp
801021ed:	56                   	push   %esi
801021ee:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021f6:	00 00 00 
  return ioapic->data;
801021f9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801021ff:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102202:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102208:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010220e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102215:	89 f0                	mov    %esi,%eax
80102217:	c1 e8 10             	shr    $0x10,%eax
8010221a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010221d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102220:	c1 e8 18             	shr    $0x18,%eax
80102223:	39 d0                	cmp    %edx,%eax
80102225:	74 16                	je     8010223d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102227:	83 ec 0c             	sub    $0xc,%esp
8010222a:	68 94 71 10 80       	push   $0x80107194
8010222f:	e8 2c e4 ff ff       	call   80100660 <cprintf>
80102234:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010223a:	83 c4 10             	add    $0x10,%esp
8010223d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	ba 10 00 00 00       	mov    $0x10,%edx
80102245:	b8 20 00 00 00       	mov    $0x20,%eax
8010224a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102250:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102252:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102260:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102263:	89 59 10             	mov    %ebx,0x10(%ecx)
80102266:	8d 5a 01             	lea    0x1(%edx),%ebx
80102269:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010226c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010226e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102270:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102276:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227d:	75 d1                	jne    80102250 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010227f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102282:	5b                   	pop    %ebx
80102283:	5e                   	pop    %esi
80102284:	5d                   	pop    %ebp
80102285:	c3                   	ret    
80102286:	8d 76 00             	lea    0x0(%esi),%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102290:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102291:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102297:	89 e5                	mov    %esp,%ebp
80102299:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010229c:	8d 50 20             	lea    0x20(%eax),%edx
8010229f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022a5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ae:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022b1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022b6:	a1 34 26 11 80       	mov    0x80112634,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022bb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022be:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022c1:	5d                   	pop    %ebp
801022c2:	c3                   	ret    
801022c3:	66 90                	xchg   %ax,%ax
801022c5:	66 90                	xchg   %ax,%ax
801022c7:	66 90                	xchg   %ax,%ax
801022c9:	66 90                	xchg   %ax,%ax
801022cb:	66 90                	xchg   %ax,%ax
801022cd:	66 90                	xchg   %ax,%ax
801022cf:	90                   	nop

801022d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	53                   	push   %ebx
801022d4:	83 ec 04             	sub    $0x4,%esp
801022d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022e0:	75 70                	jne    80102352 <kfree+0x82>
801022e2:	81 fb a8 55 11 80    	cmp    $0x801155a8,%ebx
801022e8:	72 68                	jb     80102352 <kfree+0x82>
801022ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022f5:	77 5b                	ja     80102352 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022f7:	83 ec 04             	sub    $0x4,%esp
801022fa:	68 00 10 00 00       	push   $0x1000
801022ff:	6a 01                	push   $0x1
80102301:	53                   	push   %ebx
80102302:	e8 89 21 00 00       	call   80104490 <memset>

  if(kmem.use_lock)
80102307:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	85 d2                	test   %edx,%edx
80102312:	75 2c                	jne    80102340 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102314:	a1 78 26 11 80       	mov    0x80112678,%eax
80102319:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010231b:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102320:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102326:	85 c0                	test   %eax,%eax
80102328:	75 06                	jne    80102330 <kfree+0x60>
    release(&kmem.lock);
}
8010232a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010232d:	c9                   	leave  
8010232e:	c3                   	ret    
8010232f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102330:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102337:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010233b:	e9 00 21 00 00       	jmp    80104440 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 40 26 11 80       	push   $0x80112640
80102348:	e8 43 20 00 00       	call   80104390 <acquire>
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	eb c2                	jmp    80102314 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102352:	83 ec 0c             	sub    $0xc,%esp
80102355:	68 c6 71 10 80       	push   $0x801071c6
8010235a:	e8 11 e0 ff ff       	call   80100370 <panic>
8010235f:	90                   	nop

80102360 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102365:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102368:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010236b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102371:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102377:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010237d:	39 de                	cmp    %ebx,%esi
8010237f:	72 23                	jb     801023a4 <freerange+0x44>
80102381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102388:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010238e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102391:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102397:	50                   	push   %eax
80102398:	e8 33 ff ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	39 f3                	cmp    %esi,%ebx
801023a2:	76 e4                	jbe    80102388 <freerange+0x28>
    kfree(p);
}
801023a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a7:	5b                   	pop    %ebx
801023a8:	5e                   	pop    %esi
801023a9:	5d                   	pop    %ebp
801023aa:	c3                   	ret    
801023ab:	90                   	nop
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023b8:	83 ec 08             	sub    $0x8,%esp
801023bb:	68 cc 71 10 80       	push   $0x801071cc
801023c0:	68 40 26 11 80       	push   $0x80112640
801023c5:	e8 66 1e 00 00       	call   80104230 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023cd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023d0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801023d7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ec:	39 de                	cmp    %ebx,%esi
801023ee:	72 1c                	jb     8010240c <kinit1+0x5c>
    kfree(p);
801023f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023f6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023ff:	50                   	push   %eax
80102400:	e8 cb fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102405:	83 c4 10             	add    $0x10,%esp
80102408:	39 de                	cmp    %ebx,%esi
8010240a:	73 e4                	jae    801023f0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010240c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010240f:	5b                   	pop    %ebx
80102410:	5e                   	pop    %esi
80102411:	5d                   	pop    %ebp
80102412:	c3                   	ret    
80102413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102425:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102428:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010242b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102431:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102437:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243d:	39 de                	cmp    %ebx,%esi
8010243f:	72 23                	jb     80102464 <kinit2+0x44>
80102441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102448:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010244e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102451:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102457:	50                   	push   %eax
80102458:	e8 73 fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	39 de                	cmp    %ebx,%esi
80102462:	73 e4                	jae    80102448 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102464:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010246b:	00 00 00 
}
8010246e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102487:	a1 74 26 11 80       	mov    0x80112674,%eax
8010248c:	85 c0                	test   %eax,%eax
8010248e:	75 30                	jne    801024c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102490:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102496:	85 db                	test   %ebx,%ebx
80102498:	74 1c                	je     801024b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010249a:	8b 13                	mov    (%ebx),%edx
8010249c:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024a2:	85 c0                	test   %eax,%eax
801024a4:	74 10                	je     801024b6 <kalloc+0x36>
    release(&kmem.lock);
801024a6:	83 ec 0c             	sub    $0xc,%esp
801024a9:	68 40 26 11 80       	push   $0x80112640
801024ae:	e8 8d 1f 00 00       	call   80104440 <release>
801024b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024b6:	89 d8                	mov    %ebx,%eax
801024b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024bb:	c9                   	leave  
801024bc:	c3                   	ret    
801024bd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024c0:	83 ec 0c             	sub    $0xc,%esp
801024c3:	68 40 26 11 80       	push   $0x80112640
801024c8:	e8 c3 1e 00 00       	call   80104390 <acquire>
  r = kmem.freelist;
801024cd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024d3:	83 c4 10             	add    $0x10,%esp
801024d6:	a1 74 26 11 80       	mov    0x80112674,%eax
801024db:	85 db                	test   %ebx,%ebx
801024dd:	75 bb                	jne    8010249a <kalloc+0x1a>
801024df:	eb c1                	jmp    801024a2 <kalloc+0x22>
801024e1:	66 90                	xchg   %ax,%ax
801024e3:	66 90                	xchg   %ax,%ax
801024e5:	66 90                	xchg   %ax,%ax
801024e7:	66 90                	xchg   %ax,%ax
801024e9:	66 90                	xchg   %ax,%ax
801024eb:	66 90                	xchg   %ax,%ax
801024ed:	66 90                	xchg   %ax,%ax
801024ef:	90                   	nop

801024f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801024f0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f1:	ba 64 00 00 00       	mov    $0x64,%edx
801024f6:	89 e5                	mov    %esp,%ebp
801024f8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024f9:	a8 01                	test   $0x1,%al
801024fb:	0f 84 af 00 00 00    	je     801025b0 <kbdgetc+0xc0>
80102501:	ba 60 00 00 00       	mov    $0x60,%edx
80102506:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102507:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010250a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102510:	74 7e                	je     80102590 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102512:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102514:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010251a:	79 24                	jns    80102540 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010251c:	f6 c1 40             	test   $0x40,%cl
8010251f:	75 05                	jne    80102526 <kbdgetc+0x36>
80102521:	89 c2                	mov    %eax,%edx
80102523:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102526:	0f b6 82 00 73 10 80 	movzbl -0x7fef8d00(%edx),%eax
8010252d:	83 c8 40             	or     $0x40,%eax
80102530:	0f b6 c0             	movzbl %al,%eax
80102533:	f7 d0                	not    %eax
80102535:	21 c8                	and    %ecx,%eax
80102537:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010253c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010253e:	5d                   	pop    %ebp
8010253f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102540:	f6 c1 40             	test   $0x40,%cl
80102543:	74 09                	je     8010254e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102545:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102548:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010254b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010254e:	0f b6 82 00 73 10 80 	movzbl -0x7fef8d00(%edx),%eax
80102555:	09 c1                	or     %eax,%ecx
80102557:	0f b6 82 00 72 10 80 	movzbl -0x7fef8e00(%edx),%eax
8010255e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102560:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102562:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102568:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010256b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010256e:	8b 04 85 e0 71 10 80 	mov    -0x7fef8e20(,%eax,4),%eax
80102575:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102579:	74 c3                	je     8010253e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010257b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010257e:	83 fa 19             	cmp    $0x19,%edx
80102581:	77 1d                	ja     801025a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102583:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102586:	5d                   	pop    %ebp
80102587:	c3                   	ret    
80102588:	90                   	nop
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102590:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102592:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102599:	5d                   	pop    %ebp
8010259a:	c3                   	ret    
8010259b:	90                   	nop
8010259c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025a3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025a6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025a7:	83 f9 19             	cmp    $0x19,%ecx
801025aa:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025b5:	5d                   	pop    %ebp
801025b6:	c3                   	ret    
801025b7:	89 f6                	mov    %esi,%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kbdintr>:

void
kbdintr(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025c6:	68 f0 24 10 80       	push   $0x801024f0
801025cb:	e8 20 e2 ff ff       	call   801007f0 <consoleintr>
}
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	c9                   	leave  
801025d4:	c3                   	ret    
801025d5:	66 90                	xchg   %ax,%ax
801025d7:	66 90                	xchg   %ax,%ax
801025d9:	66 90                	xchg   %ax,%ax
801025db:	66 90                	xchg   %ax,%ax
801025dd:	66 90                	xchg   %ax,%ax
801025df:	90                   	nop

801025e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801025e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801025e5:	55                   	push   %ebp
801025e6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025e8:	85 c0                	test   %eax,%eax
801025ea:	0f 84 c8 00 00 00    	je     801026b8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025f0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025f7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025fa:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025fd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102604:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102607:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010260a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102611:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102614:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102617:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010261e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102621:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102624:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010262b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010262e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102631:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102638:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010263b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010263e:	8b 50 30             	mov    0x30(%eax),%edx
80102641:	c1 ea 10             	shr    $0x10,%edx
80102644:	80 fa 03             	cmp    $0x3,%dl
80102647:	77 77                	ja     801026c0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102649:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102650:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102653:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102656:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010265d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102660:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102663:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010266a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102670:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102677:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102684:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102687:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102691:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	8b 50 20             	mov    0x20(%eax),%edx
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026a0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026a6:	80 e6 10             	and    $0x10,%dh
801026a9:	75 f5                	jne    801026a0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026b2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026b8:	5d                   	pop    %ebp
801026b9:	c3                   	ret    
801026ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
801026cd:	e9 77 ff ff ff       	jmp    80102649 <lapicinit+0x69>
801026d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801026e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801026e5:	55                   	push   %ebp
801026e6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801026e8:	85 c0                	test   %eax,%eax
801026ea:	74 0c                	je     801026f8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801026ec:	8b 40 20             	mov    0x20(%eax),%eax
}
801026ef:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801026f0:	c1 e8 18             	shr    $0x18,%eax
}
801026f3:	c3                   	ret    
801026f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801026f8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801026fa:	5d                   	pop    %ebp
801026fb:	c3                   	ret    
801026fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102700 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102700:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	74 0d                	je     80102719 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102713:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102716:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102719:	5d                   	pop    %ebp
8010271a:	c3                   	ret    
8010271b:	90                   	nop
8010271c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102720 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
}
80102723:	5d                   	pop    %ebp
80102724:	c3                   	ret    
80102725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102730 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102730:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102731:	ba 70 00 00 00       	mov    $0x70,%edx
80102736:	b8 0f 00 00 00       	mov    $0xf,%eax
8010273b:	89 e5                	mov    %esp,%ebp
8010273d:	53                   	push   %ebx
8010273e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102741:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102744:	ee                   	out    %al,(%dx)
80102745:	ba 71 00 00 00       	mov    $0x71,%edx
8010274a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010274f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102750:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102752:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102755:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010275b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010275d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102760:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102763:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102765:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102768:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102773:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102779:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010277c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102783:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102789:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102790:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102793:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102796:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010279c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027a5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ae:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027ba:	5b                   	pop    %ebx
801027bb:	5d                   	pop    %ebp
801027bc:	c3                   	ret    
801027bd:	8d 76 00             	lea    0x0(%esi),%esi

801027c0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801027c0:	55                   	push   %ebp
801027c1:	ba 70 00 00 00       	mov    $0x70,%edx
801027c6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027cb:	89 e5                	mov    %esp,%ebp
801027cd:	57                   	push   %edi
801027ce:	56                   	push   %esi
801027cf:	53                   	push   %ebx
801027d0:	83 ec 4c             	sub    $0x4c,%esp
801027d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027d4:	ba 71 00 00 00       	mov    $0x71,%edx
801027d9:	ec                   	in     (%dx),%al
801027da:	83 e0 04             	and    $0x4,%eax
801027dd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027e0:	31 db                	xor    %ebx,%ebx
801027e2:	88 45 b7             	mov    %al,-0x49(%ebp)
801027e5:	bf 70 00 00 00       	mov    $0x70,%edi
801027ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027f0:	89 d8                	mov    %ebx,%eax
801027f2:	89 fa                	mov    %edi,%edx
801027f4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f5:	b9 71 00 00 00       	mov    $0x71,%ecx
801027fa:	89 ca                	mov    %ecx,%edx
801027fc:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801027fd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102800:	89 fa                	mov    %edi,%edx
80102802:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102805:	b8 02 00 00 00       	mov    $0x2,%eax
8010280a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010280b:	89 ca                	mov    %ecx,%edx
8010280d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010280e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102811:	89 fa                	mov    %edi,%edx
80102813:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102816:	b8 04 00 00 00       	mov    $0x4,%eax
8010281b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010281c:	89 ca                	mov    %ecx,%edx
8010281e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010281f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102822:	89 fa                	mov    %edi,%edx
80102824:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102827:	b8 07 00 00 00       	mov    $0x7,%eax
8010282c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010282d:	89 ca                	mov    %ecx,%edx
8010282f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102830:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102833:	89 fa                	mov    %edi,%edx
80102835:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102838:	b8 08 00 00 00       	mov    $0x8,%eax
8010283d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283e:	89 ca                	mov    %ecx,%edx
80102840:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102841:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102844:	89 fa                	mov    %edi,%edx
80102846:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102849:	b8 09 00 00 00       	mov    $0x9,%eax
8010284e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284f:	89 ca                	mov    %ecx,%edx
80102851:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102852:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102855:	89 fa                	mov    %edi,%edx
80102857:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010285a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010285f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102860:	89 ca                	mov    %ecx,%edx
80102862:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102863:	84 c0                	test   %al,%al
80102865:	78 89                	js     801027f0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102867:	89 d8                	mov    %ebx,%eax
80102869:	89 fa                	mov    %edi,%edx
8010286b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286c:	89 ca                	mov    %ecx,%edx
8010286e:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010286f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102872:	89 fa                	mov    %edi,%edx
80102874:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102877:	b8 02 00 00 00       	mov    $0x2,%eax
8010287c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287d:	89 ca                	mov    %ecx,%edx
8010287f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102880:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102883:	89 fa                	mov    %edi,%edx
80102885:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102888:	b8 04 00 00 00       	mov    $0x4,%eax
8010288d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288e:	89 ca                	mov    %ecx,%edx
80102890:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102891:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102894:	89 fa                	mov    %edi,%edx
80102896:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102899:	b8 07 00 00 00       	mov    $0x7,%eax
8010289e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289f:	89 ca                	mov    %ecx,%edx
801028a1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028a2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a5:	89 fa                	mov    %edi,%edx
801028a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028aa:	b8 08 00 00 00       	mov    $0x8,%eax
801028af:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b0:	89 ca                	mov    %ecx,%edx
801028b2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028b3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b6:	89 fa                	mov    %edi,%edx
801028b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028bb:	b8 09 00 00 00       	mov    $0x9,%eax
801028c0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c1:	89 ca                	mov    %ecx,%edx
801028c3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028c4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028c7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801028ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028cd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801028d0:	6a 18                	push   $0x18
801028d2:	56                   	push   %esi
801028d3:	50                   	push   %eax
801028d4:	e8 07 1c 00 00       	call   801044e0 <memcmp>
801028d9:	83 c4 10             	add    $0x10,%esp
801028dc:	85 c0                	test   %eax,%eax
801028de:	0f 85 0c ff ff ff    	jne    801027f0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801028e4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028e8:	75 78                	jne    80102962 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028ea:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028ed:	89 c2                	mov    %eax,%edx
801028ef:	83 e0 0f             	and    $0xf,%eax
801028f2:	c1 ea 04             	shr    $0x4,%edx
801028f5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028fb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102901:	89 c2                	mov    %eax,%edx
80102903:	83 e0 0f             	and    $0xf,%eax
80102906:	c1 ea 04             	shr    $0x4,%edx
80102909:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010290c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102912:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102915:	89 c2                	mov    %eax,%edx
80102917:	83 e0 0f             	and    $0xf,%eax
8010291a:	c1 ea 04             	shr    $0x4,%edx
8010291d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102920:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102923:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102926:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102929:	89 c2                	mov    %eax,%edx
8010292b:	83 e0 0f             	and    $0xf,%eax
8010292e:	c1 ea 04             	shr    $0x4,%edx
80102931:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102934:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102937:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010293a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010293d:	89 c2                	mov    %eax,%edx
8010293f:	83 e0 0f             	and    $0xf,%eax
80102942:	c1 ea 04             	shr    $0x4,%edx
80102945:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102948:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010294b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010294e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102951:	89 c2                	mov    %eax,%edx
80102953:	83 e0 0f             	and    $0xf,%eax
80102956:	c1 ea 04             	shr    $0x4,%edx
80102959:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010295c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102962:	8b 75 08             	mov    0x8(%ebp),%esi
80102965:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102968:	89 06                	mov    %eax,(%esi)
8010296a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010296d:	89 46 04             	mov    %eax,0x4(%esi)
80102970:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102973:	89 46 08             	mov    %eax,0x8(%esi)
80102976:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102979:	89 46 0c             	mov    %eax,0xc(%esi)
8010297c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010297f:	89 46 10             	mov    %eax,0x10(%esi)
80102982:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102985:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102988:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
8010298f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102992:	5b                   	pop    %ebx
80102993:	5e                   	pop    %esi
80102994:	5f                   	pop    %edi
80102995:	5d                   	pop    %ebp
80102996:	c3                   	ret    
80102997:	66 90                	xchg   %ax,%ax
80102999:	66 90                	xchg   %ax,%ax
8010299b:	66 90                	xchg   %ax,%ax
8010299d:	66 90                	xchg   %ax,%ax
8010299f:	90                   	nop

801029a0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029a0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
801029a6:	85 c9                	test   %ecx,%ecx
801029a8:	0f 8e 85 00 00 00    	jle    80102a33 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029ae:	55                   	push   %ebp
801029af:	89 e5                	mov    %esp,%ebp
801029b1:	57                   	push   %edi
801029b2:	56                   	push   %esi
801029b3:	53                   	push   %ebx
801029b4:	31 db                	xor    %ebx,%ebx
801029b6:	83 ec 0c             	sub    $0xc,%esp
801029b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029c0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801029c5:	83 ec 08             	sub    $0x8,%esp
801029c8:	01 d8                	add    %ebx,%eax
801029ca:	83 c0 01             	add    $0x1,%eax
801029cd:	50                   	push   %eax
801029ce:	ff 35 c4 26 11 80    	pushl  0x801126c4
801029d4:	e8 f7 d6 ff ff       	call   801000d0 <bread>
801029d9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029db:	58                   	pop    %eax
801029dc:	5a                   	pop    %edx
801029dd:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
801029e4:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029ea:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029ed:	e8 de d6 ff ff       	call   801000d0 <bread>
801029f2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029f4:	8d 47 5c             	lea    0x5c(%edi),%eax
801029f7:	83 c4 0c             	add    $0xc,%esp
801029fa:	68 00 02 00 00       	push   $0x200
801029ff:	50                   	push   %eax
80102a00:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a03:	50                   	push   %eax
80102a04:	e8 37 1b 00 00       	call   80104540 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a09:	89 34 24             	mov    %esi,(%esp)
80102a0c:	e8 8f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a11:	89 3c 24             	mov    %edi,(%esp)
80102a14:	e8 c7 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a19:	89 34 24             	mov    %esi,(%esp)
80102a1c:	e8 bf d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a21:	83 c4 10             	add    $0x10,%esp
80102a24:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a2a:	7f 94                	jg     801029c0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a2f:	5b                   	pop    %ebx
80102a30:	5e                   	pop    %esi
80102a31:	5f                   	pop    %edi
80102a32:	5d                   	pop    %ebp
80102a33:	f3 c3                	repz ret 
80102a35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	53                   	push   %ebx
80102a44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a47:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102a4d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a53:	e8 78 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a58:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a5e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a61:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a63:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a65:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a68:	7e 1f                	jle    80102a89 <write_head+0x49>
80102a6a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102a71:	31 d2                	xor    %edx,%edx
80102a73:	90                   	nop
80102a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a78:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102a7e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102a82:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a85:	39 c2                	cmp    %eax,%edx
80102a87:	75 ef                	jne    80102a78 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102a89:	83 ec 0c             	sub    $0xc,%esp
80102a8c:	53                   	push   %ebx
80102a8d:	e8 0e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a92:	89 1c 24             	mov    %ebx,(%esp)
80102a95:	e8 46 d7 ff ff       	call   801001e0 <brelse>
}
80102a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a9d:	c9                   	leave  
80102a9e:	c3                   	ret    
80102a9f:	90                   	nop

80102aa0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	53                   	push   %ebx
80102aa4:	83 ec 2c             	sub    $0x2c,%esp
80102aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102aaa:	68 00 74 10 80       	push   $0x80107400
80102aaf:	68 80 26 11 80       	push   $0x80112680
80102ab4:	e8 77 17 00 00       	call   80104230 <initlock>
  readsb(dev, &sb);
80102ab9:	58                   	pop    %eax
80102aba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102abd:	5a                   	pop    %edx
80102abe:	50                   	push   %eax
80102abf:	53                   	push   %ebx
80102ac0:	e8 5b e9 ff ff       	call   80101420 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ac5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102acb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102acc:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ad2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ad8:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102add:	5a                   	pop    %edx
80102ade:	50                   	push   %eax
80102adf:	53                   	push   %ebx
80102ae0:	e8 eb d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ae5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ae8:	83 c4 10             	add    $0x10,%esp
80102aeb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102aed:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102af3:	7e 1c                	jle    80102b11 <initlog+0x71>
80102af5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102afc:	31 d2                	xor    %edx,%edx
80102afe:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b00:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b04:	83 c2 04             	add    $0x4,%edx
80102b07:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b0d:	39 da                	cmp    %ebx,%edx
80102b0f:	75 ef                	jne    80102b00 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b11:	83 ec 0c             	sub    $0xc,%esp
80102b14:	50                   	push   %eax
80102b15:	e8 c6 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b1a:	e8 81 fe ff ff       	call   801029a0 <install_trans>
  log.lh.n = 0;
80102b1f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b26:	00 00 00 
  write_head(); // clear the log
80102b29:	e8 12 ff ff ff       	call   80102a40 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b31:	c9                   	leave  
80102b32:	c3                   	ret    
80102b33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b46:	68 80 26 11 80       	push   $0x80112680
80102b4b:	e8 40 18 00 00       	call   80104390 <acquire>
80102b50:	83 c4 10             	add    $0x10,%esp
80102b53:	eb 18                	jmp    80102b6d <begin_op+0x2d>
80102b55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b58:	83 ec 08             	sub    $0x8,%esp
80102b5b:	68 80 26 11 80       	push   $0x80112680
80102b60:	68 80 26 11 80       	push   $0x80112680
80102b65:	e8 c6 11 00 00       	call   80103d30 <sleep>
80102b6a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b6d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b72:	85 c0                	test   %eax,%eax
80102b74:	75 e2                	jne    80102b58 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b76:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b7b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b81:	83 c0 01             	add    $0x1,%eax
80102b84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b8a:	83 fa 1e             	cmp    $0x1e,%edx
80102b8d:	7f c9                	jg     80102b58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b8f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102b92:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102b97:	68 80 26 11 80       	push   $0x80112680
80102b9c:	e8 9f 18 00 00       	call   80104440 <release>
      break;
    }
  }
}
80102ba1:	83 c4 10             	add    $0x10,%esp
80102ba4:	c9                   	leave  
80102ba5:	c3                   	ret    
80102ba6:	8d 76 00             	lea    0x0(%esi),%esi
80102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bb9:	68 80 26 11 80       	push   $0x80112680
80102bbe:	e8 cd 17 00 00       	call   80104390 <acquire>
  log.outstanding -= 1;
80102bc3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102bc8:	8b 1d c0 26 11 80    	mov    0x801126c0,%ebx
80102bce:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bd1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102bd4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bd6:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102bdb:	0f 85 23 01 00 00    	jne    80102d04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102be1:	85 c0                	test   %eax,%eax
80102be3:	0f 85 f7 00 00 00    	jne    80102ce0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102be9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102bec:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102bf3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bf6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102bf8:	68 80 26 11 80       	push   $0x80112680
80102bfd:	e8 3e 18 00 00       	call   80104440 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c02:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c08:	83 c4 10             	add    $0x10,%esp
80102c0b:	85 c9                	test   %ecx,%ecx
80102c0d:	0f 8e 8a 00 00 00    	jle    80102c9d <end_op+0xed>
80102c13:	90                   	nop
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c18:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c1d:	83 ec 08             	sub    $0x8,%esp
80102c20:	01 d8                	add    %ebx,%eax
80102c22:	83 c0 01             	add    $0x1,%eax
80102c25:	50                   	push   %eax
80102c26:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c2c:	e8 9f d4 ff ff       	call   801000d0 <bread>
80102c31:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c33:	58                   	pop    %eax
80102c34:	5a                   	pop    %edx
80102c35:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102c3c:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c42:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c45:	e8 86 d4 ff ff       	call   801000d0 <bread>
80102c4a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c4c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c4f:	83 c4 0c             	add    $0xc,%esp
80102c52:	68 00 02 00 00       	push   $0x200
80102c57:	50                   	push   %eax
80102c58:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c5b:	50                   	push   %eax
80102c5c:	e8 df 18 00 00       	call   80104540 <memmove>
    bwrite(to);  // write the log
80102c61:	89 34 24             	mov    %esi,(%esp)
80102c64:	e8 37 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c69:	89 3c 24             	mov    %edi,(%esp)
80102c6c:	e8 6f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c71:	89 34 24             	mov    %esi,(%esp)
80102c74:	e8 67 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c79:	83 c4 10             	add    $0x10,%esp
80102c7c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c82:	7c 94                	jl     80102c18 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c84:	e8 b7 fd ff ff       	call   80102a40 <write_head>
    install_trans(); // Now install writes to home locations
80102c89:	e8 12 fd ff ff       	call   801029a0 <install_trans>
    log.lh.n = 0;
80102c8e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c95:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c98:	e8 a3 fd ff ff       	call   80102a40 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102c9d:	83 ec 0c             	sub    $0xc,%esp
80102ca0:	68 80 26 11 80       	push   $0x80112680
80102ca5:	e8 e6 16 00 00       	call   80104390 <acquire>
    log.committing = 0;
    wakeup(&log);
80102caa:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102cb1:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102cb8:	00 00 00 
    wakeup(&log);
80102cbb:	e8 20 12 00 00       	call   80103ee0 <wakeup>
    release(&log.lock);
80102cc0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cc7:	e8 74 17 00 00       	call   80104440 <release>
80102ccc:	83 c4 10             	add    $0x10,%esp
  }
}
80102ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd2:	5b                   	pop    %ebx
80102cd3:	5e                   	pop    %esi
80102cd4:	5f                   	pop    %edi
80102cd5:	5d                   	pop    %ebp
80102cd6:	c3                   	ret    
80102cd7:	89 f6                	mov    %esi,%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102ce0:	83 ec 0c             	sub    $0xc,%esp
80102ce3:	68 80 26 11 80       	push   $0x80112680
80102ce8:	e8 f3 11 00 00       	call   80103ee0 <wakeup>
  }
  release(&log.lock);
80102ced:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cf4:	e8 47 17 00 00       	call   80104440 <release>
80102cf9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cff:	5b                   	pop    %ebx
80102d00:	5e                   	pop    %esi
80102d01:	5f                   	pop    %edi
80102d02:	5d                   	pop    %ebp
80102d03:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d04:	83 ec 0c             	sub    $0xc,%esp
80102d07:	68 04 74 10 80       	push   $0x80107404
80102d0c:	e8 5f d6 ff ff       	call   80100370 <panic>
80102d11:	eb 0d                	jmp    80102d20 <log_write>
80102d13:	90                   	nop
80102d14:	90                   	nop
80102d15:	90                   	nop
80102d16:	90                   	nop
80102d17:	90                   	nop
80102d18:	90                   	nop
80102d19:	90                   	nop
80102d1a:	90                   	nop
80102d1b:	90                   	nop
80102d1c:	90                   	nop
80102d1d:	90                   	nop
80102d1e:	90                   	nop
80102d1f:	90                   	nop

80102d20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d27:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d30:	83 fa 1d             	cmp    $0x1d,%edx
80102d33:	0f 8f 97 00 00 00    	jg     80102dd0 <log_write+0xb0>
80102d39:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d3e:	83 e8 01             	sub    $0x1,%eax
80102d41:	39 c2                	cmp    %eax,%edx
80102d43:	0f 8d 87 00 00 00    	jge    80102dd0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d49:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d4e:	85 c0                	test   %eax,%eax
80102d50:	0f 8e 87 00 00 00    	jle    80102ddd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d56:	83 ec 0c             	sub    $0xc,%esp
80102d59:	68 80 26 11 80       	push   $0x80112680
80102d5e:	e8 2d 16 00 00       	call   80104390 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d63:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102d69:	83 c4 10             	add    $0x10,%esp
80102d6c:	83 fa 00             	cmp    $0x0,%edx
80102d6f:	7e 50                	jle    80102dc1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d71:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d74:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d76:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
80102d7c:	75 0b                	jne    80102d89 <log_write+0x69>
80102d7e:	eb 38                	jmp    80102db8 <log_write+0x98>
80102d80:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d87:	74 2f                	je     80102db8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d89:	83 c0 01             	add    $0x1,%eax
80102d8c:	39 d0                	cmp    %edx,%eax
80102d8e:	75 f0                	jne    80102d80 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102d90:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d97:	83 c2 01             	add    $0x1,%edx
80102d9a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102da0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102da3:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102daa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dad:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dae:	e9 8d 16 00 00       	jmp    80104440 <release>
80102db3:	90                   	nop
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102db8:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102dbf:	eb df                	jmp    80102da0 <log_write+0x80>
80102dc1:	8b 43 08             	mov    0x8(%ebx),%eax
80102dc4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102dc9:	75 d5                	jne    80102da0 <log_write+0x80>
80102dcb:	eb ca                	jmp    80102d97 <log_write+0x77>
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102dd0:	83 ec 0c             	sub    $0xc,%esp
80102dd3:	68 13 74 10 80       	push   $0x80107413
80102dd8:	e8 93 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ddd:	83 ec 0c             	sub    $0xc,%esp
80102de0:	68 29 74 10 80       	push   $0x80107429
80102de5:	e8 86 d5 ff ff       	call   80100370 <panic>
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	53                   	push   %ebx
80102df4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102df7:	e8 54 09 00 00       	call   80103750 <cpuid>
80102dfc:	89 c3                	mov    %eax,%ebx
80102dfe:	e8 4d 09 00 00       	call   80103750 <cpuid>
80102e03:	83 ec 04             	sub    $0x4,%esp
80102e06:	53                   	push   %ebx
80102e07:	50                   	push   %eax
80102e08:	68 44 74 10 80       	push   $0x80107444
80102e0d:	e8 4e d8 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e12:	e8 49 29 00 00       	call   80105760 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e17:	e8 b4 08 00 00       	call   801036d0 <mycpu>
80102e1c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e1e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e23:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e2a:	e8 01 0c 00 00       	call   80103a30 <scheduler>
80102e2f:	90                   	nop

80102e30 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e36:	e8 45 3a 00 00       	call   80106880 <switchkvm>
  seginit();
80102e3b:	e8 40 39 00 00       	call   80106780 <seginit>
  lapicinit();
80102e40:	e8 9b f7 ff ff       	call   801025e0 <lapicinit>
  mpmain();
80102e45:	e8 a6 ff ff ff       	call   80102df0 <mpmain>
80102e4a:	66 90                	xchg   %ax,%ax
80102e4c:	66 90                	xchg   %ax,%ax
80102e4e:	66 90                	xchg   %ax,%ax

80102e50 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e50:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e54:	83 e4 f0             	and    $0xfffffff0,%esp
80102e57:	ff 71 fc             	pushl  -0x4(%ecx)
80102e5a:	55                   	push   %ebp
80102e5b:	89 e5                	mov    %esp,%ebp
80102e5d:	53                   	push   %ebx
80102e5e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e5f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e64:	83 ec 08             	sub    $0x8,%esp
80102e67:	68 00 00 40 80       	push   $0x80400000
80102e6c:	68 a8 55 11 80       	push   $0x801155a8
80102e71:	e8 3a f5 ff ff       	call   801023b0 <kinit1>
  kvmalloc();      // kernel page table
80102e76:	e8 a5 3e 00 00       	call   80106d20 <kvmalloc>
  mpinit();        // detect other processors
80102e7b:	e8 70 01 00 00       	call   80102ff0 <mpinit>
  lapicinit();     // interrupt controller
80102e80:	e8 5b f7 ff ff       	call   801025e0 <lapicinit>
  seginit();       // segment descriptors
80102e85:	e8 f6 38 00 00       	call   80106780 <seginit>
  picinit();       // disable pic
80102e8a:	e8 31 03 00 00       	call   801031c0 <picinit>
  ioapicinit();    // another interrupt controller
80102e8f:	e8 4c f3 ff ff       	call   801021e0 <ioapicinit>
  consoleinit();   // console hardware
80102e94:	e8 07 db ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102e99:	e8 b2 2b 00 00       	call   80105a50 <uartinit>
  pinit();         // process table
80102e9e:	e8 0d 08 00 00       	call   801036b0 <pinit>
  tvinit();        // trap vectors
80102ea3:	e8 18 28 00 00       	call   801056c0 <tvinit>
  binit();         // buffer cache
80102ea8:	e8 93 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ead:	e8 9e de ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102eb2:	e8 09 f1 ff ff       	call   80101fc0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102eb7:	83 c4 0c             	add    $0xc,%esp
80102eba:	68 8a 00 00 00       	push   $0x8a
80102ebf:	68 8c a4 10 80       	push   $0x8010a48c
80102ec4:	68 00 70 00 80       	push   $0x80007000
80102ec9:	e8 72 16 00 00       	call   80104540 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ece:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ed5:	00 00 00 
80102ed8:	83 c4 10             	add    $0x10,%esp
80102edb:	05 80 27 11 80       	add    $0x80112780,%eax
80102ee0:	39 d8                	cmp    %ebx,%eax
80102ee2:	76 6f                	jbe    80102f53 <main+0x103>
80102ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102ee8:	e8 e3 07 00 00       	call   801036d0 <mycpu>
80102eed:	39 d8                	cmp    %ebx,%eax
80102eef:	74 49                	je     80102f3a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ef1:	e8 8a f5 ff ff       	call   80102480 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ef6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102efb:	c7 05 f8 6f 00 80 30 	movl   $0x80102e30,0x80006ff8
80102f02:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f05:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f0c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f0f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f14:	0f b6 03             	movzbl (%ebx),%eax
80102f17:	83 ec 08             	sub    $0x8,%esp
80102f1a:	68 00 70 00 00       	push   $0x7000
80102f1f:	50                   	push   %eax
80102f20:	e8 0b f8 ff ff       	call   80102730 <lapicstartap>
80102f25:	83 c4 10             	add    $0x10,%esp
80102f28:	90                   	nop
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f36:	85 c0                	test   %eax,%eax
80102f38:	74 f6                	je     80102f30 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f3a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f41:	00 00 00 
80102f44:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f4a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f4f:	39 c3                	cmp    %eax,%ebx
80102f51:	72 95                	jb     80102ee8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f53:	83 ec 08             	sub    $0x8,%esp
80102f56:	68 00 00 00 8e       	push   $0x8e000000
80102f5b:	68 00 00 40 80       	push   $0x80400000
80102f60:	e8 bb f4 ff ff       	call   80102420 <kinit2>
  userinit();      // first user process
80102f65:	e8 36 08 00 00       	call   801037a0 <userinit>
  mpmain();        // finish this processor's setup
80102f6a:	e8 81 fe ff ff       	call   80102df0 <mpmain>
80102f6f:	90                   	nop

80102f70 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	57                   	push   %edi
80102f74:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f75:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f7b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102f7c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f7f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102f82:	39 de                	cmp    %ebx,%esi
80102f84:	73 48                	jae    80102fce <mpsearch1+0x5e>
80102f86:	8d 76 00             	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f90:	83 ec 04             	sub    $0x4,%esp
80102f93:	8d 7e 10             	lea    0x10(%esi),%edi
80102f96:	6a 04                	push   $0x4
80102f98:	68 58 74 10 80       	push   $0x80107458
80102f9d:	56                   	push   %esi
80102f9e:	e8 3d 15 00 00       	call   801044e0 <memcmp>
80102fa3:	83 c4 10             	add    $0x10,%esp
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	75 1e                	jne    80102fc8 <mpsearch1+0x58>
80102faa:	8d 7e 10             	lea    0x10(%esi),%edi
80102fad:	89 f2                	mov    %esi,%edx
80102faf:	31 c9                	xor    %ecx,%ecx
80102fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102fb8:	0f b6 02             	movzbl (%edx),%eax
80102fbb:	83 c2 01             	add    $0x1,%edx
80102fbe:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102fc0:	39 fa                	cmp    %edi,%edx
80102fc2:	75 f4                	jne    80102fb8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fc4:	84 c9                	test   %cl,%cl
80102fc6:	74 10                	je     80102fd8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fc8:	39 fb                	cmp    %edi,%ebx
80102fca:	89 fe                	mov    %edi,%esi
80102fcc:	77 c2                	ja     80102f90 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80102fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102fd1:	31 c0                	xor    %eax,%eax
}
80102fd3:	5b                   	pop    %ebx
80102fd4:	5e                   	pop    %esi
80102fd5:	5f                   	pop    %edi
80102fd6:	5d                   	pop    %ebp
80102fd7:	c3                   	ret    
80102fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fdb:	89 f0                	mov    %esi,%eax
80102fdd:	5b                   	pop    %ebx
80102fde:	5e                   	pop    %esi
80102fdf:	5f                   	pop    %edi
80102fe0:	5d                   	pop    %ebp
80102fe1:	c3                   	ret    
80102fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ff0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
80102ff5:	53                   	push   %ebx
80102ff6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102ff9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103000:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103007:	c1 e0 08             	shl    $0x8,%eax
8010300a:	09 d0                	or     %edx,%eax
8010300c:	c1 e0 04             	shl    $0x4,%eax
8010300f:	85 c0                	test   %eax,%eax
80103011:	75 1b                	jne    8010302e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103013:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010301a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103021:	c1 e0 08             	shl    $0x8,%eax
80103024:	09 d0                	or     %edx,%eax
80103026:	c1 e0 0a             	shl    $0xa,%eax
80103029:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010302e:	ba 00 04 00 00       	mov    $0x400,%edx
80103033:	e8 38 ff ff ff       	call   80102f70 <mpsearch1>
80103038:	85 c0                	test   %eax,%eax
8010303a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010303d:	0f 84 37 01 00 00    	je     8010317a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103043:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103046:	8b 58 04             	mov    0x4(%eax),%ebx
80103049:	85 db                	test   %ebx,%ebx
8010304b:	0f 84 43 01 00 00    	je     80103194 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103051:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103057:	83 ec 04             	sub    $0x4,%esp
8010305a:	6a 04                	push   $0x4
8010305c:	68 5d 74 10 80       	push   $0x8010745d
80103061:	56                   	push   %esi
80103062:	e8 79 14 00 00       	call   801044e0 <memcmp>
80103067:	83 c4 10             	add    $0x10,%esp
8010306a:	85 c0                	test   %eax,%eax
8010306c:	0f 85 22 01 00 00    	jne    80103194 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103072:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103079:	3c 01                	cmp    $0x1,%al
8010307b:	74 08                	je     80103085 <mpinit+0x95>
8010307d:	3c 04                	cmp    $0x4,%al
8010307f:	0f 85 0f 01 00 00    	jne    80103194 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103085:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010308c:	85 ff                	test   %edi,%edi
8010308e:	74 21                	je     801030b1 <mpinit+0xc1>
80103090:	31 d2                	xor    %edx,%edx
80103092:	31 c0                	xor    %eax,%eax
80103094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103098:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010309f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030a0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030a3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030a5:	39 c7                	cmp    %eax,%edi
801030a7:	75 ef                	jne    80103098 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030a9:	84 d2                	test   %dl,%dl
801030ab:	0f 85 e3 00 00 00    	jne    80103194 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030b1:	85 f6                	test   %esi,%esi
801030b3:	0f 84 db 00 00 00    	je     80103194 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801030b9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801030bf:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030c4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801030cb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801030d1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030d6:	01 d6                	add    %edx,%esi
801030d8:	90                   	nop
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030e0:	39 c6                	cmp    %eax,%esi
801030e2:	76 23                	jbe    80103107 <mpinit+0x117>
801030e4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801030e7:	80 fa 04             	cmp    $0x4,%dl
801030ea:	0f 87 c0 00 00 00    	ja     801031b0 <mpinit+0x1c0>
801030f0:	ff 24 95 9c 74 10 80 	jmp    *-0x7fef8b64(,%edx,4)
801030f7:	89 f6                	mov    %esi,%esi
801030f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103100:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103103:	39 c6                	cmp    %eax,%esi
80103105:	77 dd                	ja     801030e4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103107:	85 db                	test   %ebx,%ebx
80103109:	0f 84 92 00 00 00    	je     801031a1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010310f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103112:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103116:	74 15                	je     8010312d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103118:	ba 22 00 00 00       	mov    $0x22,%edx
8010311d:	b8 70 00 00 00       	mov    $0x70,%eax
80103122:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103123:	ba 23 00 00 00       	mov    $0x23,%edx
80103128:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103129:	83 c8 01             	or     $0x1,%eax
8010312c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010312d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103130:	5b                   	pop    %ebx
80103131:	5e                   	pop    %esi
80103132:	5f                   	pop    %edi
80103133:	5d                   	pop    %ebp
80103134:	c3                   	ret    
80103135:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103138:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010313e:	83 f9 07             	cmp    $0x7,%ecx
80103141:	7f 19                	jg     8010315c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103143:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103147:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010314d:	83 c1 01             	add    $0x1,%ecx
80103150:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103156:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010315c:	83 c0 14             	add    $0x14,%eax
      continue;
8010315f:	e9 7c ff ff ff       	jmp    801030e0 <mpinit+0xf0>
80103164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010316c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010316f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
80103175:	e9 66 ff ff ff       	jmp    801030e0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010317a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010317f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103184:	e8 e7 fd ff ff       	call   80102f70 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103189:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010318b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010318e:	0f 85 af fe ff ff    	jne    80103043 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103194:	83 ec 0c             	sub    $0xc,%esp
80103197:	68 62 74 10 80       	push   $0x80107462
8010319c:	e8 cf d1 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801031a1:	83 ec 0c             	sub    $0xc,%esp
801031a4:	68 7c 74 10 80       	push   $0x8010747c
801031a9:	e8 c2 d1 ff ff       	call   80100370 <panic>
801031ae:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031b0:	31 db                	xor    %ebx,%ebx
801031b2:	e9 30 ff ff ff       	jmp    801030e7 <mpinit+0xf7>
801031b7:	66 90                	xchg   %ax,%ax
801031b9:	66 90                	xchg   %ax,%ax
801031bb:	66 90                	xchg   %ax,%ax
801031bd:	66 90                	xchg   %ax,%ax
801031bf:	90                   	nop

801031c0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	ba 21 00 00 00       	mov    $0x21,%edx
801031c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031cb:	89 e5                	mov    %esp,%ebp
801031cd:	ee                   	out    %al,(%dx)
801031ce:	ba a1 00 00 00       	mov    $0xa1,%edx
801031d3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801031d4:	5d                   	pop    %ebp
801031d5:	c3                   	ret    
801031d6:	66 90                	xchg   %ax,%ax
801031d8:	66 90                	xchg   %ax,%ax
801031da:	66 90                	xchg   %ax,%ax
801031dc:	66 90                	xchg   %ax,%ax
801031de:	66 90                	xchg   %ax,%ax

801031e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	57                   	push   %edi
801031e4:	56                   	push   %esi
801031e5:	53                   	push   %ebx
801031e6:	83 ec 0c             	sub    $0xc,%esp
801031e9:	8b 75 08             	mov    0x8(%ebp),%esi
801031ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801031ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801031f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801031fb:	e8 70 db ff ff       	call   80100d70 <filealloc>
80103200:	85 c0                	test   %eax,%eax
80103202:	89 06                	mov    %eax,(%esi)
80103204:	0f 84 a8 00 00 00    	je     801032b2 <pipealloc+0xd2>
8010320a:	e8 61 db ff ff       	call   80100d70 <filealloc>
8010320f:	85 c0                	test   %eax,%eax
80103211:	89 03                	mov    %eax,(%ebx)
80103213:	0f 84 87 00 00 00    	je     801032a0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103219:	e8 62 f2 ff ff       	call   80102480 <kalloc>
8010321e:	85 c0                	test   %eax,%eax
80103220:	89 c7                	mov    %eax,%edi
80103222:	0f 84 b0 00 00 00    	je     801032d8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103228:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010322b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103232:	00 00 00 
  p->writeopen = 1;
80103235:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010323c:	00 00 00 
  p->nwrite = 0;
8010323f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103246:	00 00 00 
  p->nread = 0;
80103249:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103250:	00 00 00 
  initlock(&p->lock, "pipe");
80103253:	68 b0 74 10 80       	push   $0x801074b0
80103258:	50                   	push   %eax
80103259:	e8 d2 0f 00 00       	call   80104230 <initlock>
  (*f0)->type = FD_PIPE;
8010325e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103260:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103263:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103269:	8b 06                	mov    (%esi),%eax
8010326b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010326f:	8b 06                	mov    (%esi),%eax
80103271:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103275:	8b 06                	mov    (%esi),%eax
80103277:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010327a:	8b 03                	mov    (%ebx),%eax
8010327c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103282:	8b 03                	mov    (%ebx),%eax
80103284:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103288:	8b 03                	mov    (%ebx),%eax
8010328a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010328e:	8b 03                	mov    (%ebx),%eax
80103290:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103293:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103296:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103298:	5b                   	pop    %ebx
80103299:	5e                   	pop    %esi
8010329a:	5f                   	pop    %edi
8010329b:	5d                   	pop    %ebp
8010329c:	c3                   	ret    
8010329d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032a0:	8b 06                	mov    (%esi),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 1e                	je     801032c4 <pipealloc+0xe4>
    fileclose(*f0);
801032a6:	83 ec 0c             	sub    $0xc,%esp
801032a9:	50                   	push   %eax
801032aa:	e8 81 db ff ff       	call   80100e30 <fileclose>
801032af:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032b2:	8b 03                	mov    (%ebx),%eax
801032b4:	85 c0                	test   %eax,%eax
801032b6:	74 0c                	je     801032c4 <pipealloc+0xe4>
    fileclose(*f1);
801032b8:	83 ec 0c             	sub    $0xc,%esp
801032bb:	50                   	push   %eax
801032bc:	e8 6f db ff ff       	call   80100e30 <fileclose>
801032c1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801032c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032cc:	5b                   	pop    %ebx
801032cd:	5e                   	pop    %esi
801032ce:	5f                   	pop    %edi
801032cf:	5d                   	pop    %ebp
801032d0:	c3                   	ret    
801032d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032d8:	8b 06                	mov    (%esi),%eax
801032da:	85 c0                	test   %eax,%eax
801032dc:	75 c8                	jne    801032a6 <pipealloc+0xc6>
801032de:	eb d2                	jmp    801032b2 <pipealloc+0xd2>

801032e0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	56                   	push   %esi
801032e4:	53                   	push   %ebx
801032e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801032eb:	83 ec 0c             	sub    $0xc,%esp
801032ee:	53                   	push   %ebx
801032ef:	e8 9c 10 00 00       	call   80104390 <acquire>
  if(writable){
801032f4:	83 c4 10             	add    $0x10,%esp
801032f7:	85 f6                	test   %esi,%esi
801032f9:	74 45                	je     80103340 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801032fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103301:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103304:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010330b:	00 00 00 
    wakeup(&p->nread);
8010330e:	50                   	push   %eax
8010330f:	e8 cc 0b 00 00       	call   80103ee0 <wakeup>
80103314:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103317:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010331d:	85 d2                	test   %edx,%edx
8010331f:	75 0a                	jne    8010332b <pipeclose+0x4b>
80103321:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103327:	85 c0                	test   %eax,%eax
80103329:	74 35                	je     80103360 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010332b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010332e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103331:	5b                   	pop    %ebx
80103332:	5e                   	pop    %esi
80103333:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103334:	e9 07 11 00 00       	jmp    80104440 <release>
80103339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103340:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103346:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103349:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103350:	00 00 00 
    wakeup(&p->nwrite);
80103353:	50                   	push   %eax
80103354:	e8 87 0b 00 00       	call   80103ee0 <wakeup>
80103359:	83 c4 10             	add    $0x10,%esp
8010335c:	eb b9                	jmp    80103317 <pipeclose+0x37>
8010335e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103360:	83 ec 0c             	sub    $0xc,%esp
80103363:	53                   	push   %ebx
80103364:	e8 d7 10 00 00       	call   80104440 <release>
    kfree((char*)p);
80103369:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010336c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010336f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103372:	5b                   	pop    %ebx
80103373:	5e                   	pop    %esi
80103374:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103375:	e9 56 ef ff ff       	jmp    801022d0 <kfree>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103380 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	57                   	push   %edi
80103384:	56                   	push   %esi
80103385:	53                   	push   %ebx
80103386:	83 ec 28             	sub    $0x28,%esp
80103389:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010338c:	53                   	push   %ebx
8010338d:	e8 fe 0f 00 00       	call   80104390 <acquire>
  for(i = 0; i < n; i++){
80103392:	8b 45 10             	mov    0x10(%ebp),%eax
80103395:	83 c4 10             	add    $0x10,%esp
80103398:	85 c0                	test   %eax,%eax
8010339a:	0f 8e b9 00 00 00    	jle    80103459 <pipewrite+0xd9>
801033a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033af:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033b8:	03 4d 10             	add    0x10(%ebp),%ecx
801033bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033be:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033c4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033ca:	39 d0                	cmp    %edx,%eax
801033cc:	74 38                	je     80103406 <pipewrite+0x86>
801033ce:	eb 59                	jmp    80103429 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801033d0:	e8 9b 03 00 00       	call   80103770 <myproc>
801033d5:	8b 48 24             	mov    0x24(%eax),%ecx
801033d8:	85 c9                	test   %ecx,%ecx
801033da:	75 34                	jne    80103410 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033dc:	83 ec 0c             	sub    $0xc,%esp
801033df:	57                   	push   %edi
801033e0:	e8 fb 0a 00 00       	call   80103ee0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033e5:	58                   	pop    %eax
801033e6:	5a                   	pop    %edx
801033e7:	53                   	push   %ebx
801033e8:	56                   	push   %esi
801033e9:	e8 42 09 00 00       	call   80103d30 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801033f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801033fa:	83 c4 10             	add    $0x10,%esp
801033fd:	05 00 02 00 00       	add    $0x200,%eax
80103402:	39 c2                	cmp    %eax,%edx
80103404:	75 2a                	jne    80103430 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103406:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010340c:	85 c0                	test   %eax,%eax
8010340e:	75 c0                	jne    801033d0 <pipewrite+0x50>
        release(&p->lock);
80103410:	83 ec 0c             	sub    $0xc,%esp
80103413:	53                   	push   %ebx
80103414:	e8 27 10 00 00       	call   80104440 <release>
        return -1;
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103421:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103424:	5b                   	pop    %ebx
80103425:	5e                   	pop    %esi
80103426:	5f                   	pop    %edi
80103427:	5d                   	pop    %ebp
80103428:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103429:	89 c2                	mov    %eax,%edx
8010342b:	90                   	nop
8010342c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103430:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103433:	8d 42 01             	lea    0x1(%edx),%eax
80103436:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010343a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103440:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103446:	0f b6 09             	movzbl (%ecx),%ecx
80103449:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010344d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103450:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103453:	0f 85 65 ff ff ff    	jne    801033be <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103459:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010345f:	83 ec 0c             	sub    $0xc,%esp
80103462:	50                   	push   %eax
80103463:	e8 78 0a 00 00       	call   80103ee0 <wakeup>
  release(&p->lock);
80103468:	89 1c 24             	mov    %ebx,(%esp)
8010346b:	e8 d0 0f 00 00       	call   80104440 <release>
  return n;
80103470:	83 c4 10             	add    $0x10,%esp
80103473:	8b 45 10             	mov    0x10(%ebp),%eax
80103476:	eb a9                	jmp    80103421 <pipewrite+0xa1>
80103478:	90                   	nop
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103480 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 18             	sub    $0x18,%esp
80103489:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010348c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010348f:	53                   	push   %ebx
80103490:	e8 fb 0e 00 00       	call   80104390 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103495:	83 c4 10             	add    $0x10,%esp
80103498:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010349e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801034a4:	75 6a                	jne    80103510 <piperead+0x90>
801034a6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801034ac:	85 f6                	test   %esi,%esi
801034ae:	0f 84 cc 00 00 00    	je     80103580 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034b4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034ba:	eb 2d                	jmp    801034e9 <piperead+0x69>
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034c0:	83 ec 08             	sub    $0x8,%esp
801034c3:	53                   	push   %ebx
801034c4:	56                   	push   %esi
801034c5:	e8 66 08 00 00       	call   80103d30 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034ca:	83 c4 10             	add    $0x10,%esp
801034cd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801034d3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801034d9:	75 35                	jne    80103510 <piperead+0x90>
801034db:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801034e1:	85 d2                	test   %edx,%edx
801034e3:	0f 84 97 00 00 00    	je     80103580 <piperead+0x100>
    if(myproc()->killed){
801034e9:	e8 82 02 00 00       	call   80103770 <myproc>
801034ee:	8b 48 24             	mov    0x24(%eax),%ecx
801034f1:	85 c9                	test   %ecx,%ecx
801034f3:	74 cb                	je     801034c0 <piperead+0x40>
      release(&p->lock);
801034f5:	83 ec 0c             	sub    $0xc,%esp
801034f8:	53                   	push   %ebx
801034f9:	e8 42 0f 00 00       	call   80104440 <release>
      return -1;
801034fe:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103501:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103504:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103509:	5b                   	pop    %ebx
8010350a:	5e                   	pop    %esi
8010350b:	5f                   	pop    %edi
8010350c:	5d                   	pop    %ebp
8010350d:	c3                   	ret    
8010350e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103510:	8b 45 10             	mov    0x10(%ebp),%eax
80103513:	85 c0                	test   %eax,%eax
80103515:	7e 69                	jle    80103580 <piperead+0x100>
    if(p->nread == p->nwrite)
80103517:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010351d:	31 c9                	xor    %ecx,%ecx
8010351f:	eb 15                	jmp    80103536 <piperead+0xb6>
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103528:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010352e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103534:	74 5a                	je     80103590 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103536:	8d 70 01             	lea    0x1(%eax),%esi
80103539:	25 ff 01 00 00       	and    $0x1ff,%eax
8010353e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103544:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103549:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010354c:	83 c1 01             	add    $0x1,%ecx
8010354f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103552:	75 d4                	jne    80103528 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103554:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010355a:	83 ec 0c             	sub    $0xc,%esp
8010355d:	50                   	push   %eax
8010355e:	e8 7d 09 00 00       	call   80103ee0 <wakeup>
  release(&p->lock);
80103563:	89 1c 24             	mov    %ebx,(%esp)
80103566:	e8 d5 0e 00 00       	call   80104440 <release>
  return i;
8010356b:	8b 45 10             	mov    0x10(%ebp),%eax
8010356e:	83 c4 10             	add    $0x10,%esp
}
80103571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103574:	5b                   	pop    %ebx
80103575:	5e                   	pop    %esi
80103576:	5f                   	pop    %edi
80103577:	5d                   	pop    %ebp
80103578:	c3                   	ret    
80103579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103580:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103587:	eb cb                	jmp    80103554 <piperead+0xd4>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103590:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103593:	eb bf                	jmp    80103554 <piperead+0xd4>
80103595:	66 90                	xchg   %ax,%ax
80103597:	66 90                	xchg   %ax,%ax
80103599:	66 90                	xchg   %ax,%ax
8010359b:	66 90                	xchg   %ax,%ax
8010359d:	66 90                	xchg   %ax,%ax
8010359f:	90                   	nop

801035a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035a4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035a9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035ac:	68 20 2d 11 80       	push   $0x80112d20
801035b1:	e8 da 0d 00 00       	call   80104390 <acquire>
801035b6:	83 c4 10             	add    $0x10,%esp
801035b9:	eb 10                	jmp    801035cb <allocproc+0x2b>
801035bb:	90                   	nop
801035bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035c0:	83 eb 80             	sub    $0xffffff80,%ebx
801035c3:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801035c9:	74 75                	je     80103640 <allocproc+0xa0>
    if(p->state == UNUSED)
801035cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801035ce:	85 c0                	test   %eax,%eax
801035d0:	75 ee                	jne    801035c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035d2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801035d7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801035da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801035e1:	68 20 2d 11 80       	push   $0x80112d20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035e6:	8d 50 01             	lea    0x1(%eax),%edx
801035e9:	89 43 10             	mov    %eax,0x10(%ebx)
801035ec:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
801035f2:	e8 49 0e 00 00       	call   80104440 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801035f7:	e8 84 ee ff ff       	call   80102480 <kalloc>
801035fc:	83 c4 10             	add    $0x10,%esp
801035ff:	85 c0                	test   %eax,%eax
80103601:	89 43 08             	mov    %eax,0x8(%ebx)
80103604:	74 51                	je     80103657 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103606:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010360c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010360f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103614:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103617:	c7 40 14 b1 56 10 80 	movl   $0x801056b1,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010361e:	6a 14                	push   $0x14
80103620:	6a 00                	push   $0x0
80103622:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103623:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103626:	e8 65 0e 00 00       	call   80104490 <memset>
  p->context->eip = (uint)forkret;
8010362b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010362e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103631:	c7 40 10 60 36 10 80 	movl   $0x80103660,0x10(%eax)

  return p;
80103638:	89 d8                	mov    %ebx,%eax
}
8010363a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010363d:	c9                   	leave  
8010363e:	c3                   	ret    
8010363f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103640:	83 ec 0c             	sub    $0xc,%esp
80103643:	68 20 2d 11 80       	push   $0x80112d20
80103648:	e8 f3 0d 00 00       	call   80104440 <release>
  return 0;
8010364d:	83 c4 10             	add    $0x10,%esp
80103650:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103652:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103655:	c9                   	leave  
80103656:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103657:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010365e:	eb da                	jmp    8010363a <allocproc+0x9a>

80103660 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103666:	68 20 2d 11 80       	push   $0x80112d20
8010366b:	e8 d0 0d 00 00       	call   80104440 <release>

  if (first) {
80103670:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103675:	83 c4 10             	add    $0x10,%esp
80103678:	85 c0                	test   %eax,%eax
8010367a:	75 04                	jne    80103680 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010367c:	c9                   	leave  
8010367d:	c3                   	ret    
8010367e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103680:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103683:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010368a:	00 00 00 
    iinit(ROOTDEV);
8010368d:	6a 01                	push   $0x1
8010368f:	e8 cc dd ff ff       	call   80101460 <iinit>
    initlog(ROOTDEV);
80103694:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010369b:	e8 00 f4 ff ff       	call   80102aa0 <initlog>
801036a0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036a3:	c9                   	leave  
801036a4:	c3                   	ret    
801036a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036b0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801036b6:	68 b5 74 10 80       	push   $0x801074b5
801036bb:	68 20 2d 11 80       	push   $0x80112d20
801036c0:	e8 6b 0b 00 00       	call   80104230 <initlock>
}
801036c5:	83 c4 10             	add    $0x10,%esp
801036c8:	c9                   	leave  
801036c9:	c3                   	ret    
801036ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036d0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	56                   	push   %esi
801036d4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036d5:	9c                   	pushf  
801036d6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801036d7:	f6 c4 02             	test   $0x2,%ah
801036da:	75 5b                	jne    80103737 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801036dc:	e8 ff ef ff ff       	call   801026e0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801036e1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801036e7:	85 f6                	test   %esi,%esi
801036e9:	7e 3f                	jle    8010372a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801036eb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
801036f2:	39 d0                	cmp    %edx,%eax
801036f4:	74 30                	je     80103726 <mycpu+0x56>
801036f6:	b9 30 28 11 80       	mov    $0x80112830,%ecx
801036fb:	31 d2                	xor    %edx,%edx
801036fd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103700:	83 c2 01             	add    $0x1,%edx
80103703:	39 f2                	cmp    %esi,%edx
80103705:	74 23                	je     8010372a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103707:	0f b6 19             	movzbl (%ecx),%ebx
8010370a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103710:	39 d8                	cmp    %ebx,%eax
80103712:	75 ec                	jne    80103700 <mycpu+0x30>
      return &cpus[i];
80103714:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010371a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010371d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010371e:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103723:	5e                   	pop    %esi
80103724:	5d                   	pop    %ebp
80103725:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103726:	31 d2                	xor    %edx,%edx
80103728:	eb ea                	jmp    80103714 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010372a:	83 ec 0c             	sub    $0xc,%esp
8010372d:	68 bc 74 10 80       	push   $0x801074bc
80103732:	e8 39 cc ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103737:	83 ec 0c             	sub    $0xc,%esp
8010373a:	68 a4 75 10 80       	push   $0x801075a4
8010373f:	e8 2c cc ff ff       	call   80100370 <panic>
80103744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010374a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103750 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103756:	e8 75 ff ff ff       	call   801036d0 <mycpu>
8010375b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103760:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103761:	c1 f8 04             	sar    $0x4,%eax
80103764:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010376a:	c3                   	ret    
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103770 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
80103774:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103777:	e8 34 0b 00 00       	call   801042b0 <pushcli>
  c = mycpu();
8010377c:	e8 4f ff ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103787:	e8 64 0b 00 00       	call   801042f0 <popcli>
  return p;
}
8010378c:	83 c4 04             	add    $0x4,%esp
8010378f:	89 d8                	mov    %ebx,%eax
80103791:	5b                   	pop    %ebx
80103792:	5d                   	pop    %ebp
80103793:	c3                   	ret    
80103794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010379a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037a0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	53                   	push   %ebx
801037a4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801037a7:	e8 f4 fd ff ff       	call   801035a0 <allocproc>
801037ac:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801037ae:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801037b3:	e8 e8 34 00 00       	call   80106ca0 <setupkvm>
801037b8:	85 c0                	test   %eax,%eax
801037ba:	89 43 04             	mov    %eax,0x4(%ebx)
801037bd:	0f 84 bd 00 00 00    	je     80103880 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801037c3:	83 ec 04             	sub    $0x4,%esp
801037c6:	68 2c 00 00 00       	push   $0x2c
801037cb:	68 60 a4 10 80       	push   $0x8010a460
801037d0:	50                   	push   %eax
801037d1:	e8 da 31 00 00       	call   801069b0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801037d6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801037d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801037df:	6a 4c                	push   $0x4c
801037e1:	6a 00                	push   $0x0
801037e3:	ff 73 18             	pushl  0x18(%ebx)
801037e6:	e8 a5 0c 00 00       	call   80104490 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801037eb:	8b 43 18             	mov    0x18(%ebx),%eax
801037ee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037f3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801037f8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801037fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037ff:	8b 43 18             	mov    0x18(%ebx),%eax
80103802:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103806:	8b 43 18             	mov    0x18(%ebx),%eax
80103809:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010380d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103811:	8b 43 18             	mov    0x18(%ebx),%eax
80103814:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103818:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010381c:	8b 43 18             	mov    0x18(%ebx),%eax
8010381f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103826:	8b 43 18             	mov    0x18(%ebx),%eax
80103829:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103830:	8b 43 18             	mov    0x18(%ebx),%eax
80103833:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010383a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010383d:	6a 10                	push   $0x10
8010383f:	68 e5 74 10 80       	push   $0x801074e5
80103844:	50                   	push   %eax
80103845:	e8 46 0e 00 00       	call   80104690 <safestrcpy>
  p->cwd = namei("/");
8010384a:	c7 04 24 ee 74 10 80 	movl   $0x801074ee,(%esp)
80103851:	e8 5a e6 ff ff       	call   80101eb0 <namei>
80103856:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103859:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103860:	e8 2b 0b 00 00       	call   80104390 <acquire>

  p->state = RUNNABLE;
80103865:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010386c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103873:	e8 c8 0b 00 00       	call   80104440 <release>
}
80103878:	83 c4 10             	add    $0x10,%esp
8010387b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010387e:	c9                   	leave  
8010387f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103880:	83 ec 0c             	sub    $0xc,%esp
80103883:	68 cc 74 10 80       	push   $0x801074cc
80103888:	e8 e3 ca ff ff       	call   80100370 <panic>
8010388d:	8d 76 00             	lea    0x0(%esi),%esi

80103890 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	56                   	push   %esi
80103894:	53                   	push   %ebx
80103895:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103898:	e8 13 0a 00 00       	call   801042b0 <pushcli>
  c = mycpu();
8010389d:	e8 2e fe ff ff       	call   801036d0 <mycpu>
  p = c->proc;
801038a2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038a8:	e8 43 0a 00 00       	call   801042f0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801038ad:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801038b0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801038b2:	7e 34                	jle    801038e8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038b4:	83 ec 04             	sub    $0x4,%esp
801038b7:	01 c6                	add    %eax,%esi
801038b9:	56                   	push   %esi
801038ba:	50                   	push   %eax
801038bb:	ff 73 04             	pushl  0x4(%ebx)
801038be:	e8 2d 32 00 00       	call   80106af0 <allocuvm>
801038c3:	83 c4 10             	add    $0x10,%esp
801038c6:	85 c0                	test   %eax,%eax
801038c8:	74 36                	je     80103900 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
801038ca:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801038cd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801038cf:	53                   	push   %ebx
801038d0:	e8 cb 2f 00 00       	call   801068a0 <switchuvm>
  return 0;
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	31 c0                	xor    %eax,%eax
}
801038da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038dd:	5b                   	pop    %ebx
801038de:	5e                   	pop    %esi
801038df:	5d                   	pop    %ebp
801038e0:	c3                   	ret    
801038e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801038e8:	74 e0                	je     801038ca <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038ea:	83 ec 04             	sub    $0x4,%esp
801038ed:	01 c6                	add    %eax,%esi
801038ef:	56                   	push   %esi
801038f0:	50                   	push   %eax
801038f1:	ff 73 04             	pushl  0x4(%ebx)
801038f4:	e8 f7 32 00 00       	call   80106bf0 <deallocuvm>
801038f9:	83 c4 10             	add    $0x10,%esp
801038fc:	85 c0                	test   %eax,%eax
801038fe:	75 ca                	jne    801038ca <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103905:	eb d3                	jmp    801038da <growproc+0x4a>
80103907:	89 f6                	mov    %esi,%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103910 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	57                   	push   %edi
80103914:	56                   	push   %esi
80103915:	53                   	push   %ebx
80103916:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103919:	e8 92 09 00 00       	call   801042b0 <pushcli>
  c = mycpu();
8010391e:	e8 ad fd ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103923:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103929:	e8 c2 09 00 00       	call   801042f0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
8010392e:	e8 6d fc ff ff       	call   801035a0 <allocproc>
80103933:	85 c0                	test   %eax,%eax
80103935:	89 c7                	mov    %eax,%edi
80103937:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010393a:	0f 84 b5 00 00 00    	je     801039f5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103940:	83 ec 08             	sub    $0x8,%esp
80103943:	ff 33                	pushl  (%ebx)
80103945:	ff 73 04             	pushl  0x4(%ebx)
80103948:	e8 23 34 00 00       	call   80106d70 <copyuvm>
8010394d:	83 c4 10             	add    $0x10,%esp
80103950:	85 c0                	test   %eax,%eax
80103952:	89 47 04             	mov    %eax,0x4(%edi)
80103955:	0f 84 a1 00 00 00    	je     801039fc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010395b:	8b 03                	mov    (%ebx),%eax
8010395d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103960:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103962:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103965:	89 c8                	mov    %ecx,%eax
80103967:	8b 79 18             	mov    0x18(%ecx),%edi
8010396a:	8b 73 18             	mov    0x18(%ebx),%esi
8010396d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103972:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103974:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103976:	8b 40 18             	mov    0x18(%eax),%eax
80103979:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103980:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103984:	85 c0                	test   %eax,%eax
80103986:	74 13                	je     8010399b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103988:	83 ec 0c             	sub    $0xc,%esp
8010398b:	50                   	push   %eax
8010398c:	e8 4f d4 ff ff       	call   80100de0 <filedup>
80103991:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103994:	83 c4 10             	add    $0x10,%esp
80103997:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010399b:	83 c6 01             	add    $0x1,%esi
8010399e:	83 fe 10             	cmp    $0x10,%esi
801039a1:	75 dd                	jne    80103980 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039a3:	83 ec 0c             	sub    $0xc,%esp
801039a6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039a9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039ac:	e8 7f dc ff ff       	call   80101630 <idup>
801039b1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039b4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039b7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039ba:	8d 47 6c             	lea    0x6c(%edi),%eax
801039bd:	6a 10                	push   $0x10
801039bf:	53                   	push   %ebx
801039c0:	50                   	push   %eax
801039c1:	e8 ca 0c 00 00       	call   80104690 <safestrcpy>

  pid = np->pid;
801039c6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801039c9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039d0:	e8 bb 09 00 00       	call   80104390 <acquire>

  np->state = RUNNABLE;
801039d5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801039dc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039e3:	e8 58 0a 00 00       	call   80104440 <release>

  return pid;
801039e8:	83 c4 10             	add    $0x10,%esp
801039eb:	89 d8                	mov    %ebx,%eax
}
801039ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039f0:	5b                   	pop    %ebx
801039f1:	5e                   	pop    %esi
801039f2:	5f                   	pop    %edi
801039f3:	5d                   	pop    %ebp
801039f4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
801039f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039fa:	eb f1                	jmp    801039ed <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
801039fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	ff 77 08             	pushl  0x8(%edi)
80103a05:	e8 c6 e8 ff ff       	call   801022d0 <kfree>
    np->kstack = 0;
80103a0a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a11:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a18:	83 c4 10             	add    $0x10,%esp
80103a1b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a20:	eb cb                	jmp    801039ed <fork+0xdd>
80103a22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a30 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	57                   	push   %edi
80103a34:	56                   	push   %esi
80103a35:	53                   	push   %ebx
80103a36:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103a39:	e8 92 fc ff ff       	call   801036d0 <mycpu>
80103a3e:	8d 78 04             	lea    0x4(%eax),%edi
80103a41:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103a43:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103a4a:	00 00 00 
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103a50:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a54:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a59:	68 20 2d 11 80       	push   $0x80112d20
80103a5e:	e8 2d 09 00 00       	call   80104390 <acquire>
80103a63:	83 c4 10             	add    $0x10,%esp
80103a66:	eb 13                	jmp    80103a7b <scheduler+0x4b>
80103a68:	90                   	nop
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a70:	83 eb 80             	sub    $0xffffff80,%ebx
80103a73:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103a79:	74 55                	je     80103ad0 <scheduler+0xa0>
	p->prior = 10;
      if(p->state != RUNNABLE)
80103a7b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
	p->prior = 10;
80103a7f:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
      if(p->state != RUNNABLE)
80103a86:	75 e8                	jne    80103a70 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103a88:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103a8b:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103a91:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a92:	83 eb 80             	sub    $0xffffff80,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103a95:	e8 06 2e 00 00       	call   801068a0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103a9a:	58                   	pop    %eax
80103a9b:	5a                   	pop    %edx
80103a9c:	ff 73 9c             	pushl  -0x64(%ebx)
80103a9f:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103aa0:	c7 43 8c 04 00 00 00 	movl   $0x4,-0x74(%ebx)

      swtch(&(c->scheduler), p->context);
80103aa7:	e8 3f 0c 00 00       	call   801046eb <swtch>
      switchkvm();
80103aac:	e8 cf 2d 00 00       	call   80106880 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103ab1:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ab4:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103aba:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ac1:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ac4:	75 b5                	jne    80103a7b <scheduler+0x4b>
80103ac6:	8d 76 00             	lea    0x0(%esi),%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103ad0:	83 ec 0c             	sub    $0xc,%esp
80103ad3:	68 20 2d 11 80       	push   $0x80112d20
80103ad8:	e8 63 09 00 00       	call   80104440 <release>

  }
80103add:	83 c4 10             	add    $0x10,%esp
80103ae0:	e9 6b ff ff ff       	jmp    80103a50 <scheduler+0x20>
80103ae5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103af0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	56                   	push   %esi
80103af4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103af5:	e8 b6 07 00 00       	call   801042b0 <pushcli>
  c = mycpu();
80103afa:	e8 d1 fb ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103aff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b05:	e8 e6 07 00 00       	call   801042f0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103b0a:	83 ec 0c             	sub    $0xc,%esp
80103b0d:	68 20 2d 11 80       	push   $0x80112d20
80103b12:	e8 49 08 00 00       	call   80104360 <holding>
80103b17:	83 c4 10             	add    $0x10,%esp
80103b1a:	85 c0                	test   %eax,%eax
80103b1c:	74 4f                	je     80103b6d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103b1e:	e8 ad fb ff ff       	call   801036d0 <mycpu>
80103b23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b2a:	75 68                	jne    80103b94 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103b2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b30:	74 55                	je     80103b87 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b32:	9c                   	pushf  
80103b33:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103b34:	f6 c4 02             	test   $0x2,%ah
80103b37:	75 41                	jne    80103b7a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b39:	e8 92 fb ff ff       	call   801036d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b3e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b47:	e8 84 fb ff ff       	call   801036d0 <mycpu>
80103b4c:	83 ec 08             	sub    $0x8,%esp
80103b4f:	ff 70 04             	pushl  0x4(%eax)
80103b52:	53                   	push   %ebx
80103b53:	e8 93 0b 00 00       	call   801046eb <swtch>
  mycpu()->intena = intena;
80103b58:	e8 73 fb ff ff       	call   801036d0 <mycpu>
}
80103b5d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103b60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103b66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b69:	5b                   	pop    %ebx
80103b6a:	5e                   	pop    %esi
80103b6b:	5d                   	pop    %ebp
80103b6c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103b6d:	83 ec 0c             	sub    $0xc,%esp
80103b70:	68 f0 74 10 80       	push   $0x801074f0
80103b75:	e8 f6 c7 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 1c 75 10 80       	push   $0x8010751c
80103b82:	e8 e9 c7 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103b87:	83 ec 0c             	sub    $0xc,%esp
80103b8a:	68 0e 75 10 80       	push   $0x8010750e
80103b8f:	e8 dc c7 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103b94:	83 ec 0c             	sub    $0xc,%esp
80103b97:	68 02 75 10 80       	push   $0x80107502
80103b9c:	e8 cf c7 ff ff       	call   80100370 <panic>
80103ba1:	eb 0d                	jmp    80103bb0 <exit>
80103ba3:	90                   	nop
80103ba4:	90                   	nop
80103ba5:	90                   	nop
80103ba6:	90                   	nop
80103ba7:	90                   	nop
80103ba8:	90                   	nop
80103ba9:	90                   	nop
80103baa:	90                   	nop
80103bab:	90                   	nop
80103bac:	90                   	nop
80103bad:	90                   	nop
80103bae:	90                   	nop
80103baf:	90                   	nop

80103bb0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	57                   	push   %edi
80103bb4:	56                   	push   %esi
80103bb5:	53                   	push   %ebx
80103bb6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103bb9:	e8 f2 06 00 00       	call   801042b0 <pushcli>
  c = mycpu();
80103bbe:	e8 0d fb ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103bc3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103bc9:	e8 22 07 00 00       	call   801042f0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103bce:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103bd4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103bd7:	8d 7e 68             	lea    0x68(%esi),%edi
80103bda:	0f 84 e7 00 00 00    	je     80103cc7 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103be0:	8b 03                	mov    (%ebx),%eax
80103be2:	85 c0                	test   %eax,%eax
80103be4:	74 12                	je     80103bf8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103be6:	83 ec 0c             	sub    $0xc,%esp
80103be9:	50                   	push   %eax
80103bea:	e8 41 d2 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103bef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103bf5:	83 c4 10             	add    $0x10,%esp
80103bf8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103bfb:	39 df                	cmp    %ebx,%edi
80103bfd:	75 e1                	jne    80103be0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103bff:	e8 3c ef ff ff       	call   80102b40 <begin_op>
  iput(curproc->cwd);
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	ff 76 68             	pushl  0x68(%esi)
80103c0a:	e8 81 db ff ff       	call   80101790 <iput>
  end_op();
80103c0f:	e8 9c ef ff ff       	call   80102bb0 <end_op>
  curproc->cwd = 0;
80103c14:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103c1b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c22:	e8 69 07 00 00       	call   80104390 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103c27:	8b 56 14             	mov    0x14(%esi),%edx
80103c2a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c2d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103c32:	eb 0e                	jmp    80103c42 <exit+0x92>
80103c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c38:	83 e8 80             	sub    $0xffffff80,%eax
80103c3b:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103c40:	74 1c                	je     80103c5e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103c42:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c46:	75 f0                	jne    80103c38 <exit+0x88>
80103c48:	3b 50 20             	cmp    0x20(%eax),%edx
80103c4b:	75 eb                	jne    80103c38 <exit+0x88>
      p->state = RUNNABLE;
80103c4d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c54:	83 e8 80             	sub    $0xffffff80,%eax
80103c57:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103c5c:	75 e4                	jne    80103c42 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c5e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103c64:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c69:	eb 10                	jmp    80103c7b <exit+0xcb>
80103c6b:	90                   	nop
80103c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c70:	83 ea 80             	sub    $0xffffff80,%edx
80103c73:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103c79:	74 33                	je     80103cae <exit+0xfe>
    if(p->parent == curproc){
80103c7b:	39 72 14             	cmp    %esi,0x14(%edx)
80103c7e:	75 f0                	jne    80103c70 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103c80:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c84:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103c87:	75 e7                	jne    80103c70 <exit+0xc0>
80103c89:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103c8e:	eb 0a                	jmp    80103c9a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c90:	83 e8 80             	sub    $0xffffff80,%eax
80103c93:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103c98:	74 d6                	je     80103c70 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103c9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c9e:	75 f0                	jne    80103c90 <exit+0xe0>
80103ca0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ca3:	75 eb                	jne    80103c90 <exit+0xe0>
      p->state = RUNNABLE;
80103ca5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103cac:	eb e2                	jmp    80103c90 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103cae:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103cb5:	e8 36 fe ff ff       	call   80103af0 <sched>
  panic("zombie exit");
80103cba:	83 ec 0c             	sub    $0xc,%esp
80103cbd:	68 3d 75 10 80       	push   $0x8010753d
80103cc2:	e8 a9 c6 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103cc7:	83 ec 0c             	sub    $0xc,%esp
80103cca:	68 30 75 10 80       	push   $0x80107530
80103ccf:	e8 9c c6 ff ff       	call   80100370 <panic>
80103cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ce0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	53                   	push   %ebx
80103ce4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ce7:	68 20 2d 11 80       	push   $0x80112d20
80103cec:	e8 9f 06 00 00       	call   80104390 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103cf1:	e8 ba 05 00 00       	call   801042b0 <pushcli>
  c = mycpu();
80103cf6:	e8 d5 f9 ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103cfb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d01:	e8 ea 05 00 00       	call   801042f0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103d06:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d0d:	e8 de fd ff ff       	call   80103af0 <sched>
  release(&ptable.lock);
80103d12:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d19:	e8 22 07 00 00       	call   80104440 <release>
}
80103d1e:	83 c4 10             	add    $0x10,%esp
80103d21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d24:	c9                   	leave  
80103d25:	c3                   	ret    
80103d26:	8d 76 00             	lea    0x0(%esi),%esi
80103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d30 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
80103d35:	53                   	push   %ebx
80103d36:	83 ec 0c             	sub    $0xc,%esp
80103d39:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d3c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d3f:	e8 6c 05 00 00       	call   801042b0 <pushcli>
  c = mycpu();
80103d44:	e8 87 f9 ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103d49:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d4f:	e8 9c 05 00 00       	call   801042f0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103d54:	85 db                	test   %ebx,%ebx
80103d56:	0f 84 87 00 00 00    	je     80103de3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103d5c:	85 f6                	test   %esi,%esi
80103d5e:	74 76                	je     80103dd6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d60:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103d66:	74 50                	je     80103db8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d68:	83 ec 0c             	sub    $0xc,%esp
80103d6b:	68 20 2d 11 80       	push   $0x80112d20
80103d70:	e8 1b 06 00 00       	call   80104390 <acquire>
    release(lk);
80103d75:	89 34 24             	mov    %esi,(%esp)
80103d78:	e8 c3 06 00 00       	call   80104440 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103d7d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103d80:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103d87:	e8 64 fd ff ff       	call   80103af0 <sched>

  // Tidy up.
  p->chan = 0;
80103d8c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103d93:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d9a:	e8 a1 06 00 00       	call   80104440 <release>
    acquire(lk);
80103d9f:	89 75 08             	mov    %esi,0x8(%ebp)
80103da2:	83 c4 10             	add    $0x10,%esp
  }
}
80103da5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103da8:	5b                   	pop    %ebx
80103da9:	5e                   	pop    %esi
80103daa:	5f                   	pop    %edi
80103dab:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103dac:	e9 df 05 00 00       	jmp    80104390 <acquire>
80103db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103db8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103dbb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103dc2:	e8 29 fd ff ff       	call   80103af0 <sched>

  // Tidy up.
  p->chan = 0;
80103dc7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dd1:	5b                   	pop    %ebx
80103dd2:	5e                   	pop    %esi
80103dd3:	5f                   	pop    %edi
80103dd4:	5d                   	pop    %ebp
80103dd5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103dd6:	83 ec 0c             	sub    $0xc,%esp
80103dd9:	68 4f 75 10 80       	push   $0x8010754f
80103dde:	e8 8d c5 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103de3:	83 ec 0c             	sub    $0xc,%esp
80103de6:	68 49 75 10 80       	push   $0x80107549
80103deb:	e8 80 c5 ff ff       	call   80100370 <panic>

80103df0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	56                   	push   %esi
80103df4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103df5:	e8 b6 04 00 00       	call   801042b0 <pushcli>
  c = mycpu();
80103dfa:	e8 d1 f8 ff ff       	call   801036d0 <mycpu>
  p = c->proc;
80103dff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e05:	e8 e6 04 00 00       	call   801042f0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 20 2d 11 80       	push   $0x80112d20
80103e12:	e8 79 05 00 00       	call   80104390 <acquire>
80103e17:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103e1a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e1c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e21:	eb 10                	jmp    80103e33 <wait+0x43>
80103e23:	90                   	nop
80103e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e28:	83 eb 80             	sub    $0xffffff80,%ebx
80103e2b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103e31:	74 1d                	je     80103e50 <wait+0x60>
      if(p->parent != curproc)
80103e33:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e36:	75 f0                	jne    80103e28 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e38:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e3c:	74 30                	je     80103e6e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3e:	83 eb 80             	sub    $0xffffff80,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103e41:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e46:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103e4c:	75 e5                	jne    80103e33 <wait+0x43>
80103e4e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103e50:	85 c0                	test   %eax,%eax
80103e52:	74 70                	je     80103ec4 <wait+0xd4>
80103e54:	8b 46 24             	mov    0x24(%esi),%eax
80103e57:	85 c0                	test   %eax,%eax
80103e59:	75 69                	jne    80103ec4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103e5b:	83 ec 08             	sub    $0x8,%esp
80103e5e:	68 20 2d 11 80       	push   $0x80112d20
80103e63:	56                   	push   %esi
80103e64:	e8 c7 fe ff ff       	call   80103d30 <sleep>
  }
80103e69:	83 c4 10             	add    $0x10,%esp
80103e6c:	eb ac                	jmp    80103e1a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103e6e:	83 ec 0c             	sub    $0xc,%esp
80103e71:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103e74:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e77:	e8 54 e4 ff ff       	call   801022d0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103e7c:	5a                   	pop    %edx
80103e7d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103e80:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e87:	e8 94 2d 00 00       	call   80106c20 <freevm>
        p->pid = 0;
80103e8c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e93:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103e9a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103e9e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ea5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103eac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eb3:	e8 88 05 00 00       	call   80104440 <release>
        return pid;
80103eb8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ebb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103ebe:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ec0:	5b                   	pop    %ebx
80103ec1:	5e                   	pop    %esi
80103ec2:	5d                   	pop    %ebp
80103ec3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103ec4:	83 ec 0c             	sub    $0xc,%esp
80103ec7:	68 20 2d 11 80       	push   $0x80112d20
80103ecc:	e8 6f 05 00 00       	call   80104440 <release>
      return -1;
80103ed1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ed4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103edc:	5b                   	pop    %ebx
80103edd:	5e                   	pop    %esi
80103ede:	5d                   	pop    %ebp
80103edf:	c3                   	ret    

80103ee0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	53                   	push   %ebx
80103ee4:	83 ec 10             	sub    $0x10,%esp
80103ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103eea:	68 20 2d 11 80       	push   $0x80112d20
80103eef:	e8 9c 04 00 00       	call   80104390 <acquire>
80103ef4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103efc:	eb 0c                	jmp    80103f0a <wakeup+0x2a>
80103efe:	66 90                	xchg   %ax,%ax
80103f00:	83 e8 80             	sub    $0xffffff80,%eax
80103f03:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f08:	74 1c                	je     80103f26 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f0e:	75 f0                	jne    80103f00 <wakeup+0x20>
80103f10:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f13:	75 eb                	jne    80103f00 <wakeup+0x20>
      p->state = RUNNABLE;
80103f15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1c:	83 e8 80             	sub    $0xffffff80,%eax
80103f1f:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f24:	75 e4                	jne    80103f0a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f26:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103f2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f30:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f31:	e9 0a 05 00 00       	jmp    80104440 <release>
80103f36:	8d 76 00             	lea    0x0(%esi),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 10             	sub    $0x10,%esp
80103f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103f4a:	68 20 2d 11 80       	push   $0x80112d20
80103f4f:	e8 3c 04 00 00       	call   80104390 <acquire>
80103f54:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f57:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f5c:	eb 0c                	jmp    80103f6a <kill+0x2a>
80103f5e:	66 90                	xchg   %ax,%ax
80103f60:	83 e8 80             	sub    $0xffffff80,%eax
80103f63:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f68:	74 3e                	je     80103fa8 <kill+0x68>
    if(p->pid == pid){
80103f6a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103f6d:	75 f1                	jne    80103f60 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f6f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103f73:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f7a:	74 1c                	je     80103f98 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103f7c:	83 ec 0c             	sub    $0xc,%esp
80103f7f:	68 20 2d 11 80       	push   $0x80112d20
80103f84:	e8 b7 04 00 00       	call   80104440 <release>
      return 0;
80103f89:	83 c4 10             	add    $0x10,%esp
80103f8c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f91:	c9                   	leave  
80103f92:	c3                   	ret    
80103f93:	90                   	nop
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103f98:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f9f:	eb db                	jmp    80103f7c <kill+0x3c>
80103fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103fa8:	83 ec 0c             	sub    $0xc,%esp
80103fab:	68 20 2d 11 80       	push   $0x80112d20
80103fb0:	e8 8b 04 00 00       	call   80104440 <release>
  return -1;
80103fb5:	83 c4 10             	add    $0x10,%esp
80103fb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103fbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fc0:	c9                   	leave  
80103fc1:	c3                   	ret    
80103fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
80103fd6:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103fd9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103fde:	83 ec 3c             	sub    $0x3c,%esp
80103fe1:	eb 24                	jmp    80104007 <procdump+0x37>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103fe8:	83 ec 0c             	sub    $0xc,%esp
80103feb:	68 db 78 10 80       	push   $0x801078db
80103ff0:	e8 6b c6 ff ff       	call   80100660 <cprintf>
80103ff5:	83 c4 10             	add    $0x10,%esp
80103ff8:	83 eb 80             	sub    $0xffffff80,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffb:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80104001:	0f 84 81 00 00 00    	je     80104088 <procdump+0xb8>
    if(p->state == UNUSED)
80104007:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010400a:	85 c0                	test   %eax,%eax
8010400c:	74 ea                	je     80103ff8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010400e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104011:	ba 60 75 10 80       	mov    $0x80107560,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104016:	77 11                	ja     80104029 <procdump+0x59>
80104018:	8b 14 85 cc 75 10 80 	mov    -0x7fef8a34(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010401f:	b8 60 75 10 80       	mov    $0x80107560,%eax
80104024:	85 d2                	test   %edx,%edx
80104026:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104029:	53                   	push   %ebx
8010402a:	52                   	push   %edx
8010402b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010402e:	68 64 75 10 80       	push   $0x80107564
80104033:	e8 28 c6 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104038:	83 c4 10             	add    $0x10,%esp
8010403b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010403f:	75 a7                	jne    80103fe8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104041:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104044:	83 ec 08             	sub    $0x8,%esp
80104047:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010404a:	50                   	push   %eax
8010404b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010404e:	8b 40 0c             	mov    0xc(%eax),%eax
80104051:	83 c0 08             	add    $0x8,%eax
80104054:	50                   	push   %eax
80104055:	e8 f6 01 00 00       	call   80104250 <getcallerpcs>
8010405a:	83 c4 10             	add    $0x10,%esp
8010405d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104060:	8b 17                	mov    (%edi),%edx
80104062:	85 d2                	test   %edx,%edx
80104064:	74 82                	je     80103fe8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104066:	83 ec 08             	sub    $0x8,%esp
80104069:	83 c7 04             	add    $0x4,%edi
8010406c:	52                   	push   %edx
8010406d:	68 a1 6f 10 80       	push   $0x80106fa1
80104072:	e8 e9 c5 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104077:	83 c4 10             	add    $0x10,%esp
8010407a:	39 f7                	cmp    %esi,%edi
8010407c:	75 e2                	jne    80104060 <procdump+0x90>
8010407e:	e9 65 ff ff ff       	jmp    80103fe8 <procdump+0x18>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104088:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010408b:	5b                   	pop    %ebx
8010408c:	5e                   	pop    %esi
8010408d:	5f                   	pop    %edi
8010408e:	5d                   	pop    %ebp
8010408f:	c3                   	ret    

80104090 <cps>:

int
cps(void)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	56                   	push   %esi
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
80104094:	be 60 75 10 80       	mov    $0x80107560,%esi
  }
}

int
cps(void)
{
80104099:	53                   	push   %ebx
8010409a:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010409f:	90                   	nop
  struct proc *p;
  char *state;
  //uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
801040a0:	8b 43 a0             	mov    -0x60(%ebx),%eax
801040a3:	85 c0                	test   %eax,%eax
801040a5:	74 3b                	je     801040e2 <cps+0x52>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040a7:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801040aa:	ba 60 75 10 80       	mov    $0x80107560,%edx
  //uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040af:	77 0c                	ja     801040bd <cps+0x2d>
801040b1:	8b 14 85 cc 75 10 80 	mov    -0x7fef8a34(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801040b8:	85 d2                	test   %edx,%edx
801040ba:	0f 44 d6             	cmove  %esi,%edx
    cprintf("%d %s %s %d", p->pid, state, p->name, p->prior);
801040bd:	83 ec 0c             	sub    $0xc,%esp
801040c0:	ff 73 10             	pushl  0x10(%ebx)
801040c3:	53                   	push   %ebx
801040c4:	52                   	push   %edx
801040c5:	ff 73 a4             	pushl  -0x5c(%ebx)
801040c8:	68 6d 75 10 80       	push   $0x8010756d
801040cd:	e8 8e c5 ff ff       	call   80100660 <cprintf>
    cprintf("\n");
801040d2:	83 c4 14             	add    $0x14,%esp
801040d5:	68 db 78 10 80       	push   $0x801078db
801040da:	e8 81 c5 ff ff       	call   80100660 <cprintf>
801040df:	83 c4 10             	add    $0x10,%esp
801040e2:	83 eb 80             	sub    $0xffffff80,%ebx
  //int i;
  struct proc *p;
  char *state;
  //uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040e5:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
801040eb:	75 b3                	jne    801040a0 <cps+0x10>
      state = "???";
    cprintf("%d %s %s %d", p->pid, state, p->name, p->prior);
    cprintf("\n");
  }
return 22;
}
801040ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040f0:	b8 16 00 00 00       	mov    $0x16,%eax
801040f5:	5b                   	pop    %ebx
801040f6:	5e                   	pop    %esi
801040f7:	5d                   	pop    %ebp
801040f8:	c3                   	ret    
801040f9:	66 90                	xchg   %ax,%ax
801040fb:	66 90                	xchg   %ax,%ax
801040fd:	66 90                	xchg   %ax,%ax
801040ff:	90                   	nop

80104100 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 0c             	sub    $0xc,%esp
80104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010410a:	68 e4 75 10 80       	push   $0x801075e4
8010410f:	8d 43 04             	lea    0x4(%ebx),%eax
80104112:	50                   	push   %eax
80104113:	e8 18 01 00 00       	call   80104230 <initlock>
  lk->name = name;
80104118:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010411b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104121:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104124:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010412b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010412e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104131:	c9                   	leave  
80104132:	c3                   	ret    
80104133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104140 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	56                   	push   %esi
80104144:	53                   	push   %ebx
80104145:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104148:	83 ec 0c             	sub    $0xc,%esp
8010414b:	8d 73 04             	lea    0x4(%ebx),%esi
8010414e:	56                   	push   %esi
8010414f:	e8 3c 02 00 00       	call   80104390 <acquire>
  while (lk->locked) {
80104154:	8b 13                	mov    (%ebx),%edx
80104156:	83 c4 10             	add    $0x10,%esp
80104159:	85 d2                	test   %edx,%edx
8010415b:	74 16                	je     80104173 <acquiresleep+0x33>
8010415d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104160:	83 ec 08             	sub    $0x8,%esp
80104163:	56                   	push   %esi
80104164:	53                   	push   %ebx
80104165:	e8 c6 fb ff ff       	call   80103d30 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010416a:	8b 03                	mov    (%ebx),%eax
8010416c:	83 c4 10             	add    $0x10,%esp
8010416f:	85 c0                	test   %eax,%eax
80104171:	75 ed                	jne    80104160 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104173:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104179:	e8 f2 f5 ff ff       	call   80103770 <myproc>
8010417e:	8b 40 10             	mov    0x10(%eax),%eax
80104181:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104184:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104187:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010418a:	5b                   	pop    %ebx
8010418b:	5e                   	pop    %esi
8010418c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010418d:	e9 ae 02 00 00       	jmp    80104440 <release>
80104192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041a0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	56                   	push   %esi
801041a4:	53                   	push   %ebx
801041a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	8d 73 04             	lea    0x4(%ebx),%esi
801041ae:	56                   	push   %esi
801041af:	e8 dc 01 00 00       	call   80104390 <acquire>
  lk->locked = 0;
801041b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801041ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801041c1:	89 1c 24             	mov    %ebx,(%esp)
801041c4:	e8 17 fd ff ff       	call   80103ee0 <wakeup>
  release(&lk->lk);
801041c9:	89 75 08             	mov    %esi,0x8(%ebp)
801041cc:	83 c4 10             	add    $0x10,%esp
}
801041cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d2:	5b                   	pop    %ebx
801041d3:	5e                   	pop    %esi
801041d4:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801041d5:	e9 66 02 00 00       	jmp    80104440 <release>
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041e0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	53                   	push   %ebx
801041e6:	31 ff                	xor    %edi,%edi
801041e8:	83 ec 18             	sub    $0x18,%esp
801041eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801041ee:	8d 73 04             	lea    0x4(%ebx),%esi
801041f1:	56                   	push   %esi
801041f2:	e8 99 01 00 00       	call   80104390 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801041f7:	8b 03                	mov    (%ebx),%eax
801041f9:	83 c4 10             	add    $0x10,%esp
801041fc:	85 c0                	test   %eax,%eax
801041fe:	74 13                	je     80104213 <holdingsleep+0x33>
80104200:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104203:	e8 68 f5 ff ff       	call   80103770 <myproc>
80104208:	39 58 10             	cmp    %ebx,0x10(%eax)
8010420b:	0f 94 c0             	sete   %al
8010420e:	0f b6 c0             	movzbl %al,%eax
80104211:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104213:	83 ec 0c             	sub    $0xc,%esp
80104216:	56                   	push   %esi
80104217:	e8 24 02 00 00       	call   80104440 <release>
  return r;
}
8010421c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010421f:	89 f8                	mov    %edi,%eax
80104221:	5b                   	pop    %ebx
80104222:	5e                   	pop    %esi
80104223:	5f                   	pop    %edi
80104224:	5d                   	pop    %ebp
80104225:	c3                   	ret    
80104226:	66 90                	xchg   %ax,%ax
80104228:	66 90                	xchg   %ax,%ax
8010422a:	66 90                	xchg   %ax,%ax
8010422c:	66 90                	xchg   %ax,%ax
8010422e:	66 90                	xchg   %ax,%ax

80104230 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104236:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104239:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010423f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104242:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104249:	5d                   	pop    %ebp
8010424a:	c3                   	ret    
8010424b:	90                   	nop
8010424c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104250 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104254:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104257:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010425a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010425d:	31 c0                	xor    %eax,%eax
8010425f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104260:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104266:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010426c:	77 1a                	ja     80104288 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010426e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104271:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104274:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104277:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104279:	83 f8 0a             	cmp    $0xa,%eax
8010427c:	75 e2                	jne    80104260 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010427e:	5b                   	pop    %ebx
8010427f:	5d                   	pop    %ebp
80104280:	c3                   	ret    
80104281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104288:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010428f:	83 c0 01             	add    $0x1,%eax
80104292:	83 f8 0a             	cmp    $0xa,%eax
80104295:	74 e7                	je     8010427e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104297:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010429e:	83 c0 01             	add    $0x1,%eax
801042a1:	83 f8 0a             	cmp    $0xa,%eax
801042a4:	75 e2                	jne    80104288 <getcallerpcs+0x38>
801042a6:	eb d6                	jmp    8010427e <getcallerpcs+0x2e>
801042a8:	90                   	nop
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	53                   	push   %ebx
801042b4:	83 ec 04             	sub    $0x4,%esp
801042b7:	9c                   	pushf  
801042b8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801042b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801042ba:	e8 11 f4 ff ff       	call   801036d0 <mycpu>
801042bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801042c5:	85 c0                	test   %eax,%eax
801042c7:	75 11                	jne    801042da <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801042c9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801042cf:	e8 fc f3 ff ff       	call   801036d0 <mycpu>
801042d4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801042da:	e8 f1 f3 ff ff       	call   801036d0 <mycpu>
801042df:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801042e6:	83 c4 04             	add    $0x4,%esp
801042e9:	5b                   	pop    %ebx
801042ea:	5d                   	pop    %ebp
801042eb:	c3                   	ret    
801042ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042f0 <popcli>:

void
popcli(void)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042f6:	9c                   	pushf  
801042f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801042f8:	f6 c4 02             	test   $0x2,%ah
801042fb:	75 52                	jne    8010434f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801042fd:	e8 ce f3 ff ff       	call   801036d0 <mycpu>
80104302:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104308:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010430b:	85 d2                	test   %edx,%edx
8010430d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104313:	78 2d                	js     80104342 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104315:	e8 b6 f3 ff ff       	call   801036d0 <mycpu>
8010431a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104320:	85 d2                	test   %edx,%edx
80104322:	74 0c                	je     80104330 <popcli+0x40>
    sti();
}
80104324:	c9                   	leave  
80104325:	c3                   	ret    
80104326:	8d 76 00             	lea    0x0(%esi),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104330:	e8 9b f3 ff ff       	call   801036d0 <mycpu>
80104335:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010433b:	85 c0                	test   %eax,%eax
8010433d:	74 e5                	je     80104324 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010433f:	fb                   	sti    
    sti();
}
80104340:	c9                   	leave  
80104341:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104342:	83 ec 0c             	sub    $0xc,%esp
80104345:	68 06 76 10 80       	push   $0x80107606
8010434a:	e8 21 c0 ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010434f:	83 ec 0c             	sub    $0xc,%esp
80104352:	68 ef 75 10 80       	push   $0x801075ef
80104357:	e8 14 c0 ff ff       	call   80100370 <panic>
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104360 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	8b 75 08             	mov    0x8(%ebp),%esi
80104368:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
8010436a:	e8 41 ff ff ff       	call   801042b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010436f:	8b 06                	mov    (%esi),%eax
80104371:	85 c0                	test   %eax,%eax
80104373:	74 10                	je     80104385 <holding+0x25>
80104375:	8b 5e 08             	mov    0x8(%esi),%ebx
80104378:	e8 53 f3 ff ff       	call   801036d0 <mycpu>
8010437d:	39 c3                	cmp    %eax,%ebx
8010437f:	0f 94 c3             	sete   %bl
80104382:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104385:	e8 66 ff ff ff       	call   801042f0 <popcli>
  return r;
}
8010438a:	89 d8                	mov    %ebx,%eax
8010438c:	5b                   	pop    %ebx
8010438d:	5e                   	pop    %esi
8010438e:	5d                   	pop    %ebp
8010438f:	c3                   	ret    

80104390 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	53                   	push   %ebx
80104394:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104397:	e8 14 ff ff ff       	call   801042b0 <pushcli>
  if(holding(lk))
8010439c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010439f:	83 ec 0c             	sub    $0xc,%esp
801043a2:	53                   	push   %ebx
801043a3:	e8 b8 ff ff ff       	call   80104360 <holding>
801043a8:	83 c4 10             	add    $0x10,%esp
801043ab:	85 c0                	test   %eax,%eax
801043ad:	0f 85 7d 00 00 00    	jne    80104430 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801043b3:	ba 01 00 00 00       	mov    $0x1,%edx
801043b8:	eb 09                	jmp    801043c3 <acquire+0x33>
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043c0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043c3:	89 d0                	mov    %edx,%eax
801043c5:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801043c8:	85 c0                	test   %eax,%eax
801043ca:	75 f4                	jne    801043c0 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801043cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043d4:	e8 f7 f2 ff ff       	call   801036d0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043d9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801043db:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043de:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e1:	31 c0                	xor    %eax,%eax
801043e3:	90                   	nop
801043e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043e8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043ee:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043f4:	77 1a                	ja     80104410 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043f6:	8b 5a 04             	mov    0x4(%edx),%ebx
801043f9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043fc:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043ff:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104401:	83 f8 0a             	cmp    $0xa,%eax
80104404:	75 e2                	jne    801043e8 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104406:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104409:	c9                   	leave  
8010440a:	c3                   	ret    
8010440b:	90                   	nop
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104410:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104417:	83 c0 01             	add    $0x1,%eax
8010441a:	83 f8 0a             	cmp    $0xa,%eax
8010441d:	74 e7                	je     80104406 <acquire+0x76>
    pcs[i] = 0;
8010441f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104426:	83 c0 01             	add    $0x1,%eax
80104429:	83 f8 0a             	cmp    $0xa,%eax
8010442c:	75 e2                	jne    80104410 <acquire+0x80>
8010442e:	eb d6                	jmp    80104406 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104430:	83 ec 0c             	sub    $0xc,%esp
80104433:	68 0d 76 10 80       	push   $0x8010760d
80104438:	e8 33 bf ff ff       	call   80100370 <panic>
8010443d:	8d 76 00             	lea    0x0(%esi),%esi

80104440 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	53                   	push   %ebx
80104444:	83 ec 10             	sub    $0x10,%esp
80104447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010444a:	53                   	push   %ebx
8010444b:	e8 10 ff ff ff       	call   80104360 <holding>
80104450:	83 c4 10             	add    $0x10,%esp
80104453:	85 c0                	test   %eax,%eax
80104455:	74 22                	je     80104479 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104457:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010445e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104465:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010446a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104470:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104473:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104474:	e9 77 fe ff ff       	jmp    801042f0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104479:	83 ec 0c             	sub    $0xc,%esp
8010447c:	68 15 76 10 80       	push   $0x80107615
80104481:	e8 ea be ff ff       	call   80100370 <panic>
80104486:	66 90                	xchg   %ax,%ax
80104488:	66 90                	xchg   %ax,%ax
8010448a:	66 90                	xchg   %ax,%ax
8010448c:	66 90                	xchg   %ax,%ax
8010448e:	66 90                	xchg   %ax,%ax

80104490 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	57                   	push   %edi
80104494:	53                   	push   %ebx
80104495:	8b 55 08             	mov    0x8(%ebp),%edx
80104498:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010449b:	f6 c2 03             	test   $0x3,%dl
8010449e:	75 05                	jne    801044a5 <memset+0x15>
801044a0:	f6 c1 03             	test   $0x3,%cl
801044a3:	74 13                	je     801044b8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801044a5:	89 d7                	mov    %edx,%edi
801044a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801044aa:	fc                   	cld    
801044ab:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801044ad:	5b                   	pop    %ebx
801044ae:	89 d0                	mov    %edx,%eax
801044b0:	5f                   	pop    %edi
801044b1:	5d                   	pop    %ebp
801044b2:	c3                   	ret    
801044b3:	90                   	nop
801044b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801044b8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801044bc:	c1 e9 02             	shr    $0x2,%ecx
801044bf:	89 fb                	mov    %edi,%ebx
801044c1:	89 f8                	mov    %edi,%eax
801044c3:	c1 e3 18             	shl    $0x18,%ebx
801044c6:	c1 e0 10             	shl    $0x10,%eax
801044c9:	09 d8                	or     %ebx,%eax
801044cb:	09 f8                	or     %edi,%eax
801044cd:	c1 e7 08             	shl    $0x8,%edi
801044d0:	09 f8                	or     %edi,%eax
801044d2:	89 d7                	mov    %edx,%edi
801044d4:	fc                   	cld    
801044d5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801044d7:	5b                   	pop    %ebx
801044d8:	89 d0                	mov    %edx,%eax
801044da:	5f                   	pop    %edi
801044db:	5d                   	pop    %ebp
801044dc:	c3                   	ret    
801044dd:	8d 76 00             	lea    0x0(%esi),%esi

801044e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	57                   	push   %edi
801044e4:	56                   	push   %esi
801044e5:	8b 45 10             	mov    0x10(%ebp),%eax
801044e8:	53                   	push   %ebx
801044e9:	8b 75 0c             	mov    0xc(%ebp),%esi
801044ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801044ef:	85 c0                	test   %eax,%eax
801044f1:	74 29                	je     8010451c <memcmp+0x3c>
    if(*s1 != *s2)
801044f3:	0f b6 13             	movzbl (%ebx),%edx
801044f6:	0f b6 0e             	movzbl (%esi),%ecx
801044f9:	38 d1                	cmp    %dl,%cl
801044fb:	75 2b                	jne    80104528 <memcmp+0x48>
801044fd:	8d 78 ff             	lea    -0x1(%eax),%edi
80104500:	31 c0                	xor    %eax,%eax
80104502:	eb 14                	jmp    80104518 <memcmp+0x38>
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104508:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010450d:	83 c0 01             	add    $0x1,%eax
80104510:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104514:	38 ca                	cmp    %cl,%dl
80104516:	75 10                	jne    80104528 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104518:	39 f8                	cmp    %edi,%eax
8010451a:	75 ec                	jne    80104508 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010451c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010451d:	31 c0                	xor    %eax,%eax
}
8010451f:	5e                   	pop    %esi
80104520:	5f                   	pop    %edi
80104521:	5d                   	pop    %ebp
80104522:	c3                   	ret    
80104523:	90                   	nop
80104524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104528:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010452b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010452c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010452e:	5e                   	pop    %esi
8010452f:	5f                   	pop    %edi
80104530:	5d                   	pop    %ebp
80104531:	c3                   	ret    
80104532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 45 08             	mov    0x8(%ebp),%eax
80104548:	8b 75 0c             	mov    0xc(%ebp),%esi
8010454b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010454e:	39 c6                	cmp    %eax,%esi
80104550:	73 2e                	jae    80104580 <memmove+0x40>
80104552:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104555:	39 c8                	cmp    %ecx,%eax
80104557:	73 27                	jae    80104580 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104559:	85 db                	test   %ebx,%ebx
8010455b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010455e:	74 17                	je     80104577 <memmove+0x37>
      *--d = *--s;
80104560:	29 d9                	sub    %ebx,%ecx
80104562:	89 cb                	mov    %ecx,%ebx
80104564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104568:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010456c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010456f:	83 ea 01             	sub    $0x1,%edx
80104572:	83 fa ff             	cmp    $0xffffffff,%edx
80104575:	75 f1                	jne    80104568 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104577:	5b                   	pop    %ebx
80104578:	5e                   	pop    %esi
80104579:	5d                   	pop    %ebp
8010457a:	c3                   	ret    
8010457b:	90                   	nop
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104580:	31 d2                	xor    %edx,%edx
80104582:	85 db                	test   %ebx,%ebx
80104584:	74 f1                	je     80104577 <memmove+0x37>
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104590:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104594:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104597:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010459a:	39 d3                	cmp    %edx,%ebx
8010459c:	75 f2                	jne    80104590 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010459e:	5b                   	pop    %ebx
8010459f:	5e                   	pop    %esi
801045a0:	5d                   	pop    %ebp
801045a1:	c3                   	ret    
801045a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801045b3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801045b4:	eb 8a                	jmp    80104540 <memmove>
801045b6:	8d 76 00             	lea    0x0(%esi),%esi
801045b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045c8:	53                   	push   %ebx
801045c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801045cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801045cf:	85 c9                	test   %ecx,%ecx
801045d1:	74 37                	je     8010460a <strncmp+0x4a>
801045d3:	0f b6 17             	movzbl (%edi),%edx
801045d6:	0f b6 1e             	movzbl (%esi),%ebx
801045d9:	84 d2                	test   %dl,%dl
801045db:	74 3f                	je     8010461c <strncmp+0x5c>
801045dd:	38 d3                	cmp    %dl,%bl
801045df:	75 3b                	jne    8010461c <strncmp+0x5c>
801045e1:	8d 47 01             	lea    0x1(%edi),%eax
801045e4:	01 cf                	add    %ecx,%edi
801045e6:	eb 1b                	jmp    80104603 <strncmp+0x43>
801045e8:	90                   	nop
801045e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045f0:	0f b6 10             	movzbl (%eax),%edx
801045f3:	84 d2                	test   %dl,%dl
801045f5:	74 21                	je     80104618 <strncmp+0x58>
801045f7:	0f b6 19             	movzbl (%ecx),%ebx
801045fa:	83 c0 01             	add    $0x1,%eax
801045fd:	89 ce                	mov    %ecx,%esi
801045ff:	38 da                	cmp    %bl,%dl
80104601:	75 19                	jne    8010461c <strncmp+0x5c>
80104603:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104605:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104608:	75 e6                	jne    801045f0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010460a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010460b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010460d:	5e                   	pop    %esi
8010460e:	5f                   	pop    %edi
8010460f:	5d                   	pop    %ebp
80104610:	c3                   	ret    
80104611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104618:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010461c:	0f b6 c2             	movzbl %dl,%eax
8010461f:	29 d8                	sub    %ebx,%eax
}
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5f                   	pop    %edi
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	56                   	push   %esi
80104634:	53                   	push   %ebx
80104635:	8b 45 08             	mov    0x8(%ebp),%eax
80104638:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010463b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010463e:	89 c2                	mov    %eax,%edx
80104640:	eb 19                	jmp    8010465b <strncpy+0x2b>
80104642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104648:	83 c3 01             	add    $0x1,%ebx
8010464b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010464f:	83 c2 01             	add    $0x1,%edx
80104652:	84 c9                	test   %cl,%cl
80104654:	88 4a ff             	mov    %cl,-0x1(%edx)
80104657:	74 09                	je     80104662 <strncpy+0x32>
80104659:	89 f1                	mov    %esi,%ecx
8010465b:	85 c9                	test   %ecx,%ecx
8010465d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104660:	7f e6                	jg     80104648 <strncpy+0x18>
    ;
  while(n-- > 0)
80104662:	31 c9                	xor    %ecx,%ecx
80104664:	85 f6                	test   %esi,%esi
80104666:	7e 17                	jle    8010467f <strncpy+0x4f>
80104668:	90                   	nop
80104669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104670:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104674:	89 f3                	mov    %esi,%ebx
80104676:	83 c1 01             	add    $0x1,%ecx
80104679:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010467b:	85 db                	test   %ebx,%ebx
8010467d:	7f f1                	jg     80104670 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010467f:	5b                   	pop    %ebx
80104680:	5e                   	pop    %esi
80104681:	5d                   	pop    %ebp
80104682:	c3                   	ret    
80104683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104698:	8b 45 08             	mov    0x8(%ebp),%eax
8010469b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010469e:	85 c9                	test   %ecx,%ecx
801046a0:	7e 26                	jle    801046c8 <safestrcpy+0x38>
801046a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801046a6:	89 c1                	mov    %eax,%ecx
801046a8:	eb 17                	jmp    801046c1 <safestrcpy+0x31>
801046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801046b0:	83 c2 01             	add    $0x1,%edx
801046b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801046b7:	83 c1 01             	add    $0x1,%ecx
801046ba:	84 db                	test   %bl,%bl
801046bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801046bf:	74 04                	je     801046c5 <safestrcpy+0x35>
801046c1:	39 f2                	cmp    %esi,%edx
801046c3:	75 eb                	jne    801046b0 <safestrcpy+0x20>
    ;
  *s = 0;
801046c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801046c8:	5b                   	pop    %ebx
801046c9:	5e                   	pop    %esi
801046ca:	5d                   	pop    %ebp
801046cb:	c3                   	ret    
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046d0 <strlen>:

int
strlen(const char *s)
{
801046d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801046d1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801046d3:	89 e5                	mov    %esp,%ebp
801046d5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801046d8:	80 3a 00             	cmpb   $0x0,(%edx)
801046db:	74 0c                	je     801046e9 <strlen+0x19>
801046dd:	8d 76 00             	lea    0x0(%esi),%esi
801046e0:	83 c0 01             	add    $0x1,%eax
801046e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801046e7:	75 f7                	jne    801046e0 <strlen+0x10>
    ;
  return n;
}
801046e9:	5d                   	pop    %ebp
801046ea:	c3                   	ret    

801046eb <swtch>:
801046eb:	8b 44 24 04          	mov    0x4(%esp),%eax
801046ef:	8b 54 24 08          	mov    0x8(%esp),%edx
801046f3:	55                   	push   %ebp
801046f4:	53                   	push   %ebx
801046f5:	56                   	push   %esi
801046f6:	57                   	push   %edi
801046f7:	89 20                	mov    %esp,(%eax)
801046f9:	89 d4                	mov    %edx,%esp
801046fb:	5f                   	pop    %edi
801046fc:	5e                   	pop    %esi
801046fd:	5b                   	pop    %ebx
801046fe:	5d                   	pop    %ebp
801046ff:	c3                   	ret    

80104700 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	53                   	push   %ebx
80104704:	83 ec 04             	sub    $0x4,%esp
80104707:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010470a:	e8 61 f0 ff ff       	call   80103770 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010470f:	8b 00                	mov    (%eax),%eax
80104711:	39 d8                	cmp    %ebx,%eax
80104713:	76 1b                	jbe    80104730 <fetchint+0x30>
80104715:	8d 53 04             	lea    0x4(%ebx),%edx
80104718:	39 d0                	cmp    %edx,%eax
8010471a:	72 14                	jb     80104730 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010471c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010471f:	8b 13                	mov    (%ebx),%edx
80104721:	89 10                	mov    %edx,(%eax)
  return 0;
80104723:	31 c0                	xor    %eax,%eax
}
80104725:	83 c4 04             	add    $0x4,%esp
80104728:	5b                   	pop    %ebx
80104729:	5d                   	pop    %ebp
8010472a:	c3                   	ret    
8010472b:	90                   	nop
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104735:	eb ee                	jmp    80104725 <fetchint+0x25>
80104737:	89 f6                	mov    %esi,%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 04             	sub    $0x4,%esp
80104747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010474a:	e8 21 f0 ff ff       	call   80103770 <myproc>

  if(addr >= curproc->sz)
8010474f:	39 18                	cmp    %ebx,(%eax)
80104751:	76 29                	jbe    8010477c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104753:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104756:	89 da                	mov    %ebx,%edx
80104758:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010475a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010475c:	39 c3                	cmp    %eax,%ebx
8010475e:	73 1c                	jae    8010477c <fetchstr+0x3c>
    if(*s == 0)
80104760:	80 3b 00             	cmpb   $0x0,(%ebx)
80104763:	75 10                	jne    80104775 <fetchstr+0x35>
80104765:	eb 29                	jmp    80104790 <fetchstr+0x50>
80104767:	89 f6                	mov    %esi,%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104770:	80 3a 00             	cmpb   $0x0,(%edx)
80104773:	74 1b                	je     80104790 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104775:	83 c2 01             	add    $0x1,%edx
80104778:	39 d0                	cmp    %edx,%eax
8010477a:	77 f4                	ja     80104770 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010477c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010477f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104784:	5b                   	pop    %ebx
80104785:	5d                   	pop    %ebp
80104786:	c3                   	ret    
80104787:	89 f6                	mov    %esi,%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104790:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104793:	89 d0                	mov    %edx,%eax
80104795:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104797:	5b                   	pop    %ebx
80104798:	5d                   	pop    %ebp
80104799:	c3                   	ret    
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801047a5:	e8 c6 ef ff ff       	call   80103770 <myproc>
801047aa:	8b 40 18             	mov    0x18(%eax),%eax
801047ad:	8b 55 08             	mov    0x8(%ebp),%edx
801047b0:	8b 40 44             	mov    0x44(%eax),%eax
801047b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801047b6:	e8 b5 ef ff ff       	call   80103770 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047bb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801047bd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047c0:	39 c6                	cmp    %eax,%esi
801047c2:	73 1c                	jae    801047e0 <argint+0x40>
801047c4:	8d 53 08             	lea    0x8(%ebx),%edx
801047c7:	39 d0                	cmp    %edx,%eax
801047c9:	72 15                	jb     801047e0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
801047cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ce:	8b 53 04             	mov    0x4(%ebx),%edx
801047d1:	89 10                	mov    %edx,(%eax)
  return 0;
801047d3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801047d5:	5b                   	pop    %ebx
801047d6:	5e                   	pop    %esi
801047d7:	5d                   	pop    %ebp
801047d8:	c3                   	ret    
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801047e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047e5:	eb ee                	jmp    801047d5 <argint+0x35>
801047e7:	89 f6                	mov    %esi,%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047f0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	83 ec 10             	sub    $0x10,%esp
801047f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801047fb:	e8 70 ef ff ff       	call   80103770 <myproc>
80104800:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104802:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104805:	83 ec 08             	sub    $0x8,%esp
80104808:	50                   	push   %eax
80104809:	ff 75 08             	pushl  0x8(%ebp)
8010480c:	e8 8f ff ff ff       	call   801047a0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104811:	c1 e8 1f             	shr    $0x1f,%eax
80104814:	83 c4 10             	add    $0x10,%esp
80104817:	84 c0                	test   %al,%al
80104819:	75 2d                	jne    80104848 <argptr+0x58>
8010481b:	89 d8                	mov    %ebx,%eax
8010481d:	c1 e8 1f             	shr    $0x1f,%eax
80104820:	84 c0                	test   %al,%al
80104822:	75 24                	jne    80104848 <argptr+0x58>
80104824:	8b 16                	mov    (%esi),%edx
80104826:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104829:	39 c2                	cmp    %eax,%edx
8010482b:	76 1b                	jbe    80104848 <argptr+0x58>
8010482d:	01 c3                	add    %eax,%ebx
8010482f:	39 da                	cmp    %ebx,%edx
80104831:	72 15                	jb     80104848 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104833:	8b 55 0c             	mov    0xc(%ebp),%edx
80104836:	89 02                	mov    %eax,(%edx)
  return 0;
80104838:	31 c0                	xor    %eax,%eax
}
8010483a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010483d:	5b                   	pop    %ebx
8010483e:	5e                   	pop    %esi
8010483f:	5d                   	pop    %ebp
80104840:	c3                   	ret    
80104841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010484d:	eb eb                	jmp    8010483a <argptr+0x4a>
8010484f:	90                   	nop

80104850 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104856:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104859:	50                   	push   %eax
8010485a:	ff 75 08             	pushl  0x8(%ebp)
8010485d:	e8 3e ff ff ff       	call   801047a0 <argint>
80104862:	83 c4 10             	add    $0x10,%esp
80104865:	85 c0                	test   %eax,%eax
80104867:	78 17                	js     80104880 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104869:	83 ec 08             	sub    $0x8,%esp
8010486c:	ff 75 0c             	pushl  0xc(%ebp)
8010486f:	ff 75 f4             	pushl  -0xc(%ebp)
80104872:	e8 c9 fe ff ff       	call   80104740 <fetchstr>
80104877:	83 c4 10             	add    $0x10,%esp
}
8010487a:	c9                   	leave  
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104885:	c9                   	leave  
80104886:	c3                   	ret    
80104887:	89 f6                	mov    %esi,%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <syscall>:
[SYS_cps]     sys_cps,
};

void
syscall(void)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104895:	e8 d6 ee ff ff       	call   80103770 <myproc>

  num = curproc->tf->eax;
8010489a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
8010489d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010489f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801048a2:	8d 50 ff             	lea    -0x1(%eax),%edx
801048a5:	83 fa 15             	cmp    $0x15,%edx
801048a8:	77 1e                	ja     801048c8 <syscall+0x38>
801048aa:	8b 14 85 40 76 10 80 	mov    -0x7fef89c0(,%eax,4),%edx
801048b1:	85 d2                	test   %edx,%edx
801048b3:	74 13                	je     801048c8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801048b5:	ff d2                	call   *%edx
801048b7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801048ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048bd:	5b                   	pop    %ebx
801048be:	5e                   	pop    %esi
801048bf:	5d                   	pop    %ebp
801048c0:	c3                   	ret    
801048c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801048c8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801048c9:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801048cc:	50                   	push   %eax
801048cd:	ff 73 10             	pushl  0x10(%ebx)
801048d0:	68 1d 76 10 80       	push   $0x8010761d
801048d5:	e8 86 bd ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
801048da:	8b 43 18             	mov    0x18(%ebx),%eax
801048dd:	83 c4 10             	add    $0x10,%esp
801048e0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801048e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048ea:	5b                   	pop    %ebx
801048eb:	5e                   	pop    %esi
801048ec:	5d                   	pop    %ebp
801048ed:	c3                   	ret    
801048ee:	66 90                	xchg   %ax,%ax

801048f0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	57                   	push   %edi
801048f4:	56                   	push   %esi
801048f5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801048f6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801048f9:	83 ec 34             	sub    $0x34,%esp
801048fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801048ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104902:	56                   	push   %esi
80104903:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104904:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104907:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010490a:	e8 c1 d5 ff ff       	call   80101ed0 <nameiparent>
8010490f:	83 c4 10             	add    $0x10,%esp
80104912:	85 c0                	test   %eax,%eax
80104914:	0f 84 f6 00 00 00    	je     80104a10 <create+0x120>
    return 0;
  ilock(dp);
8010491a:	83 ec 0c             	sub    $0xc,%esp
8010491d:	89 c7                	mov    %eax,%edi
8010491f:	50                   	push   %eax
80104920:	e8 3b cd ff ff       	call   80101660 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104925:	83 c4 0c             	add    $0xc,%esp
80104928:	6a 00                	push   $0x0
8010492a:	56                   	push   %esi
8010492b:	57                   	push   %edi
8010492c:	e8 5f d2 ff ff       	call   80101b90 <dirlookup>
80104931:	83 c4 10             	add    $0x10,%esp
80104934:	85 c0                	test   %eax,%eax
80104936:	89 c3                	mov    %eax,%ebx
80104938:	74 56                	je     80104990 <create+0xa0>
    iunlockput(dp);
8010493a:	83 ec 0c             	sub    $0xc,%esp
8010493d:	57                   	push   %edi
8010493e:	e8 ad cf ff ff       	call   801018f0 <iunlockput>
    ilock(ip);
80104943:	89 1c 24             	mov    %ebx,(%esp)
80104946:	e8 15 cd ff ff       	call   80101660 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010494b:	83 c4 10             	add    $0x10,%esp
8010494e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104953:	75 1b                	jne    80104970 <create+0x80>
80104955:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010495a:	89 d8                	mov    %ebx,%eax
8010495c:	75 12                	jne    80104970 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010495e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104961:	5b                   	pop    %ebx
80104962:	5e                   	pop    %esi
80104963:	5f                   	pop    %edi
80104964:	5d                   	pop    %ebp
80104965:	c3                   	ret    
80104966:	8d 76 00             	lea    0x0(%esi),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104970:	83 ec 0c             	sub    $0xc,%esp
80104973:	53                   	push   %ebx
80104974:	e8 77 cf ff ff       	call   801018f0 <iunlockput>
    return 0;
80104979:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010497c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010497f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104981:	5b                   	pop    %ebx
80104982:	5e                   	pop    %esi
80104983:	5f                   	pop    %edi
80104984:	5d                   	pop    %ebp
80104985:	c3                   	ret    
80104986:	8d 76 00             	lea    0x0(%esi),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104990:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104994:	83 ec 08             	sub    $0x8,%esp
80104997:	50                   	push   %eax
80104998:	ff 37                	pushl  (%edi)
8010499a:	e8 51 cb ff ff       	call   801014f0 <ialloc>
8010499f:	83 c4 10             	add    $0x10,%esp
801049a2:	85 c0                	test   %eax,%eax
801049a4:	89 c3                	mov    %eax,%ebx
801049a6:	0f 84 cc 00 00 00    	je     80104a78 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
801049ac:	83 ec 0c             	sub    $0xc,%esp
801049af:	50                   	push   %eax
801049b0:	e8 ab cc ff ff       	call   80101660 <ilock>
  ip->major = major;
801049b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801049b9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
801049bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801049c1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
801049c5:	b8 01 00 00 00       	mov    $0x1,%eax
801049ca:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801049ce:	89 1c 24             	mov    %ebx,(%esp)
801049d1:	e8 da cb ff ff       	call   801015b0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801049d6:	83 c4 10             	add    $0x10,%esp
801049d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801049de:	74 40                	je     80104a20 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801049e0:	83 ec 04             	sub    $0x4,%esp
801049e3:	ff 73 04             	pushl  0x4(%ebx)
801049e6:	56                   	push   %esi
801049e7:	57                   	push   %edi
801049e8:	e8 03 d4 ff ff       	call   80101df0 <dirlink>
801049ed:	83 c4 10             	add    $0x10,%esp
801049f0:	85 c0                	test   %eax,%eax
801049f2:	78 77                	js     80104a6b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
801049f4:	83 ec 0c             	sub    $0xc,%esp
801049f7:	57                   	push   %edi
801049f8:	e8 f3 ce ff ff       	call   801018f0 <iunlockput>

  return ip;
801049fd:	83 c4 10             	add    $0x10,%esp
}
80104a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104a03:	89 d8                	mov    %ebx,%eax
}
80104a05:	5b                   	pop    %ebx
80104a06:	5e                   	pop    %esi
80104a07:	5f                   	pop    %edi
80104a08:	5d                   	pop    %ebp
80104a09:	c3                   	ret    
80104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104a10:	31 c0                	xor    %eax,%eax
80104a12:	e9 47 ff ff ff       	jmp    8010495e <create+0x6e>
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104a20:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104a25:	83 ec 0c             	sub    $0xc,%esp
80104a28:	57                   	push   %edi
80104a29:	e8 82 cb ff ff       	call   801015b0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104a2e:	83 c4 0c             	add    $0xc,%esp
80104a31:	ff 73 04             	pushl  0x4(%ebx)
80104a34:	68 b8 76 10 80       	push   $0x801076b8
80104a39:	53                   	push   %ebx
80104a3a:	e8 b1 d3 ff ff       	call   80101df0 <dirlink>
80104a3f:	83 c4 10             	add    $0x10,%esp
80104a42:	85 c0                	test   %eax,%eax
80104a44:	78 18                	js     80104a5e <create+0x16e>
80104a46:	83 ec 04             	sub    $0x4,%esp
80104a49:	ff 77 04             	pushl  0x4(%edi)
80104a4c:	68 b7 76 10 80       	push   $0x801076b7
80104a51:	53                   	push   %ebx
80104a52:	e8 99 d3 ff ff       	call   80101df0 <dirlink>
80104a57:	83 c4 10             	add    $0x10,%esp
80104a5a:	85 c0                	test   %eax,%eax
80104a5c:	79 82                	jns    801049e0 <create+0xf0>
      panic("create dots");
80104a5e:	83 ec 0c             	sub    $0xc,%esp
80104a61:	68 ab 76 10 80       	push   $0x801076ab
80104a66:	e8 05 b9 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104a6b:	83 ec 0c             	sub    $0xc,%esp
80104a6e:	68 ba 76 10 80       	push   $0x801076ba
80104a73:	e8 f8 b8 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104a78:	83 ec 0c             	sub    $0xc,%esp
80104a7b:	68 9c 76 10 80       	push   $0x8010769c
80104a80:	e8 eb b8 ff ff       	call   80100370 <panic>
80104a85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a90 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
80104a95:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104a97:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104a9a:	89 d3                	mov    %edx,%ebx
80104a9c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104a9f:	50                   	push   %eax
80104aa0:	6a 00                	push   $0x0
80104aa2:	e8 f9 fc ff ff       	call   801047a0 <argint>
80104aa7:	83 c4 10             	add    $0x10,%esp
80104aaa:	85 c0                	test   %eax,%eax
80104aac:	78 32                	js     80104ae0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104aae:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ab2:	77 2c                	ja     80104ae0 <argfd.constprop.0+0x50>
80104ab4:	e8 b7 ec ff ff       	call   80103770 <myproc>
80104ab9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104abc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104ac0:	85 c0                	test   %eax,%eax
80104ac2:	74 1c                	je     80104ae0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104ac4:	85 f6                	test   %esi,%esi
80104ac6:	74 02                	je     80104aca <argfd.constprop.0+0x3a>
    *pfd = fd;
80104ac8:	89 16                	mov    %edx,(%esi)
  if(pf)
80104aca:	85 db                	test   %ebx,%ebx
80104acc:	74 22                	je     80104af0 <argfd.constprop.0+0x60>
    *pf = f;
80104ace:	89 03                	mov    %eax,(%ebx)
  return 0;
80104ad0:	31 c0                	xor    %eax,%eax
}
80104ad2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ad5:	5b                   	pop    %ebx
80104ad6:	5e                   	pop    %esi
80104ad7:	5d                   	pop    %ebp
80104ad8:	c3                   	ret    
80104ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ae0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104ae3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104ae8:	5b                   	pop    %ebx
80104ae9:	5e                   	pop    %esi
80104aea:	5d                   	pop    %ebp
80104aeb:	c3                   	ret    
80104aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104af0:	31 c0                	xor    %eax,%eax
80104af2:	eb de                	jmp    80104ad2 <argfd.constprop.0+0x42>
80104af4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104afa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b00 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104b00:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b01:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104b03:	89 e5                	mov    %esp,%ebp
80104b05:	56                   	push   %esi
80104b06:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b07:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104b0a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b0d:	e8 7e ff ff ff       	call   80104a90 <argfd.constprop.0>
80104b12:	85 c0                	test   %eax,%eax
80104b14:	78 1a                	js     80104b30 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104b16:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104b18:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104b1b:	e8 50 ec ff ff       	call   80103770 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104b20:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104b24:	85 d2                	test   %edx,%edx
80104b26:	74 18                	je     80104b40 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104b28:	83 c3 01             	add    $0x1,%ebx
80104b2b:	83 fb 10             	cmp    $0x10,%ebx
80104b2e:	75 f0                	jne    80104b20 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104b30:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104b33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104b38:	5b                   	pop    %ebx
80104b39:	5e                   	pop    %esi
80104b3a:	5d                   	pop    %ebp
80104b3b:	c3                   	ret    
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104b40:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104b44:	83 ec 0c             	sub    $0xc,%esp
80104b47:	ff 75 f4             	pushl  -0xc(%ebp)
80104b4a:	e8 91 c2 ff ff       	call   80100de0 <filedup>
  return fd;
80104b4f:	83 c4 10             	add    $0x10,%esp
}
80104b52:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104b55:	89 d8                	mov    %ebx,%eax
}
80104b57:	5b                   	pop    %ebx
80104b58:	5e                   	pop    %esi
80104b59:	5d                   	pop    %ebp
80104b5a:	c3                   	ret    
80104b5b:	90                   	nop
80104b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b60 <sys_read>:

int
sys_read(void)
{
80104b60:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b61:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104b63:	89 e5                	mov    %esp,%ebp
80104b65:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104b6b:	e8 20 ff ff ff       	call   80104a90 <argfd.constprop.0>
80104b70:	85 c0                	test   %eax,%eax
80104b72:	78 4c                	js     80104bc0 <sys_read+0x60>
80104b74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b77:	83 ec 08             	sub    $0x8,%esp
80104b7a:	50                   	push   %eax
80104b7b:	6a 02                	push   $0x2
80104b7d:	e8 1e fc ff ff       	call   801047a0 <argint>
80104b82:	83 c4 10             	add    $0x10,%esp
80104b85:	85 c0                	test   %eax,%eax
80104b87:	78 37                	js     80104bc0 <sys_read+0x60>
80104b89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b8c:	83 ec 04             	sub    $0x4,%esp
80104b8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104b92:	50                   	push   %eax
80104b93:	6a 01                	push   $0x1
80104b95:	e8 56 fc ff ff       	call   801047f0 <argptr>
80104b9a:	83 c4 10             	add    $0x10,%esp
80104b9d:	85 c0                	test   %eax,%eax
80104b9f:	78 1f                	js     80104bc0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ba1:	83 ec 04             	sub    $0x4,%esp
80104ba4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ba7:	ff 75 f4             	pushl  -0xc(%ebp)
80104baa:	ff 75 ec             	pushl  -0x14(%ebp)
80104bad:	e8 9e c3 ff ff       	call   80100f50 <fileread>
80104bb2:	83 c4 10             	add    $0x10,%esp
}
80104bb5:	c9                   	leave  
80104bb6:	c3                   	ret    
80104bb7:	89 f6                	mov    %esi,%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104bc5:	c9                   	leave  
80104bc6:	c3                   	ret    
80104bc7:	89 f6                	mov    %esi,%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <sys_write>:

int
sys_write(void)
{
80104bd0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104bd3:	89 e5                	mov    %esp,%ebp
80104bd5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104bdb:	e8 b0 fe ff ff       	call   80104a90 <argfd.constprop.0>
80104be0:	85 c0                	test   %eax,%eax
80104be2:	78 4c                	js     80104c30 <sys_write+0x60>
80104be4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104be7:	83 ec 08             	sub    $0x8,%esp
80104bea:	50                   	push   %eax
80104beb:	6a 02                	push   $0x2
80104bed:	e8 ae fb ff ff       	call   801047a0 <argint>
80104bf2:	83 c4 10             	add    $0x10,%esp
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	78 37                	js     80104c30 <sys_write+0x60>
80104bf9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bfc:	83 ec 04             	sub    $0x4,%esp
80104bff:	ff 75 f0             	pushl  -0x10(%ebp)
80104c02:	50                   	push   %eax
80104c03:	6a 01                	push   $0x1
80104c05:	e8 e6 fb ff ff       	call   801047f0 <argptr>
80104c0a:	83 c4 10             	add    $0x10,%esp
80104c0d:	85 c0                	test   %eax,%eax
80104c0f:	78 1f                	js     80104c30 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104c11:	83 ec 04             	sub    $0x4,%esp
80104c14:	ff 75 f0             	pushl  -0x10(%ebp)
80104c17:	ff 75 f4             	pushl  -0xc(%ebp)
80104c1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c1d:	e8 be c3 ff ff       	call   80100fe0 <filewrite>
80104c22:	83 c4 10             	add    $0x10,%esp
}
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104c35:	c9                   	leave  
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <sys_close>:

int
sys_close(void)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104c46:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104c49:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c4c:	e8 3f fe ff ff       	call   80104a90 <argfd.constprop.0>
80104c51:	85 c0                	test   %eax,%eax
80104c53:	78 2b                	js     80104c80 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104c55:	e8 16 eb ff ff       	call   80103770 <myproc>
80104c5a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104c5d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104c60:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104c67:	00 
  fileclose(f);
80104c68:	ff 75 f4             	pushl  -0xc(%ebp)
80104c6b:	e8 c0 c1 ff ff       	call   80100e30 <fileclose>
  return 0;
80104c70:	83 c4 10             	add    $0x10,%esp
80104c73:	31 c0                	xor    %eax,%eax
}
80104c75:	c9                   	leave  
80104c76:	c3                   	ret    
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104c85:	c9                   	leave  
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_fstat>:

int
sys_fstat(void)
{
80104c90:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c91:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c98:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104c9b:	e8 f0 fd ff ff       	call   80104a90 <argfd.constprop.0>
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 2c                	js     80104cd0 <sys_fstat+0x40>
80104ca4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ca7:	83 ec 04             	sub    $0x4,%esp
80104caa:	6a 14                	push   $0x14
80104cac:	50                   	push   %eax
80104cad:	6a 01                	push   $0x1
80104caf:	e8 3c fb ff ff       	call   801047f0 <argptr>
80104cb4:	83 c4 10             	add    $0x10,%esp
80104cb7:	85 c0                	test   %eax,%eax
80104cb9:	78 15                	js     80104cd0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104cbb:	83 ec 08             	sub    $0x8,%esp
80104cbe:	ff 75 f4             	pushl  -0xc(%ebp)
80104cc1:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc4:	e8 37 c2 ff ff       	call   80100f00 <filestat>
80104cc9:	83 c4 10             	add    $0x10,%esp
}
80104ccc:	c9                   	leave  
80104ccd:	c3                   	ret    
80104cce:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	56                   	push   %esi
80104ce5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ce6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ce9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104cec:	50                   	push   %eax
80104ced:	6a 00                	push   $0x0
80104cef:	e8 5c fb ff ff       	call   80104850 <argstr>
80104cf4:	83 c4 10             	add    $0x10,%esp
80104cf7:	85 c0                	test   %eax,%eax
80104cf9:	0f 88 fb 00 00 00    	js     80104dfa <sys_link+0x11a>
80104cff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d02:	83 ec 08             	sub    $0x8,%esp
80104d05:	50                   	push   %eax
80104d06:	6a 01                	push   $0x1
80104d08:	e8 43 fb ff ff       	call   80104850 <argstr>
80104d0d:	83 c4 10             	add    $0x10,%esp
80104d10:	85 c0                	test   %eax,%eax
80104d12:	0f 88 e2 00 00 00    	js     80104dfa <sys_link+0x11a>
    return -1;

  begin_op();
80104d18:	e8 23 de ff ff       	call   80102b40 <begin_op>
  if((ip = namei(old)) == 0){
80104d1d:	83 ec 0c             	sub    $0xc,%esp
80104d20:	ff 75 d4             	pushl  -0x2c(%ebp)
80104d23:	e8 88 d1 ff ff       	call   80101eb0 <namei>
80104d28:	83 c4 10             	add    $0x10,%esp
80104d2b:	85 c0                	test   %eax,%eax
80104d2d:	89 c3                	mov    %eax,%ebx
80104d2f:	0f 84 f3 00 00 00    	je     80104e28 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104d35:	83 ec 0c             	sub    $0xc,%esp
80104d38:	50                   	push   %eax
80104d39:	e8 22 c9 ff ff       	call   80101660 <ilock>
  if(ip->type == T_DIR){
80104d3e:	83 c4 10             	add    $0x10,%esp
80104d41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d46:	0f 84 c4 00 00 00    	je     80104e10 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104d4c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104d51:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104d54:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104d57:	53                   	push   %ebx
80104d58:	e8 53 c8 ff ff       	call   801015b0 <iupdate>
  iunlock(ip);
80104d5d:	89 1c 24             	mov    %ebx,(%esp)
80104d60:	e8 db c9 ff ff       	call   80101740 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104d65:	58                   	pop    %eax
80104d66:	5a                   	pop    %edx
80104d67:	57                   	push   %edi
80104d68:	ff 75 d0             	pushl  -0x30(%ebp)
80104d6b:	e8 60 d1 ff ff       	call   80101ed0 <nameiparent>
80104d70:	83 c4 10             	add    $0x10,%esp
80104d73:	85 c0                	test   %eax,%eax
80104d75:	89 c6                	mov    %eax,%esi
80104d77:	74 5b                	je     80104dd4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104d79:	83 ec 0c             	sub    $0xc,%esp
80104d7c:	50                   	push   %eax
80104d7d:	e8 de c8 ff ff       	call   80101660 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	8b 03                	mov    (%ebx),%eax
80104d87:	39 06                	cmp    %eax,(%esi)
80104d89:	75 3d                	jne    80104dc8 <sys_link+0xe8>
80104d8b:	83 ec 04             	sub    $0x4,%esp
80104d8e:	ff 73 04             	pushl  0x4(%ebx)
80104d91:	57                   	push   %edi
80104d92:	56                   	push   %esi
80104d93:	e8 58 d0 ff ff       	call   80101df0 <dirlink>
80104d98:	83 c4 10             	add    $0x10,%esp
80104d9b:	85 c0                	test   %eax,%eax
80104d9d:	78 29                	js     80104dc8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104d9f:	83 ec 0c             	sub    $0xc,%esp
80104da2:	56                   	push   %esi
80104da3:	e8 48 cb ff ff       	call   801018f0 <iunlockput>
  iput(ip);
80104da8:	89 1c 24             	mov    %ebx,(%esp)
80104dab:	e8 e0 c9 ff ff       	call   80101790 <iput>

  end_op();
80104db0:	e8 fb dd ff ff       	call   80102bb0 <end_op>

  return 0;
80104db5:	83 c4 10             	add    $0x10,%esp
80104db8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104dba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dbd:	5b                   	pop    %ebx
80104dbe:	5e                   	pop    %esi
80104dbf:	5f                   	pop    %edi
80104dc0:	5d                   	pop    %ebp
80104dc1:	c3                   	ret    
80104dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104dc8:	83 ec 0c             	sub    $0xc,%esp
80104dcb:	56                   	push   %esi
80104dcc:	e8 1f cb ff ff       	call   801018f0 <iunlockput>
    goto bad;
80104dd1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104dd4:	83 ec 0c             	sub    $0xc,%esp
80104dd7:	53                   	push   %ebx
80104dd8:	e8 83 c8 ff ff       	call   80101660 <ilock>
  ip->nlink--;
80104ddd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104de2:	89 1c 24             	mov    %ebx,(%esp)
80104de5:	e8 c6 c7 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80104dea:	89 1c 24             	mov    %ebx,(%esp)
80104ded:	e8 fe ca ff ff       	call   801018f0 <iunlockput>
  end_op();
80104df2:	e8 b9 dd ff ff       	call   80102bb0 <end_op>
  return -1;
80104df7:	83 c4 10             	add    $0x10,%esp
}
80104dfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104dfd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e02:	5b                   	pop    %ebx
80104e03:	5e                   	pop    %esi
80104e04:	5f                   	pop    %edi
80104e05:	5d                   	pop    %ebp
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104e10:	83 ec 0c             	sub    $0xc,%esp
80104e13:	53                   	push   %ebx
80104e14:	e8 d7 ca ff ff       	call   801018f0 <iunlockput>
    end_op();
80104e19:	e8 92 dd ff ff       	call   80102bb0 <end_op>
    return -1;
80104e1e:	83 c4 10             	add    $0x10,%esp
80104e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e26:	eb 92                	jmp    80104dba <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104e28:	e8 83 dd ff ff       	call   80102bb0 <end_op>
    return -1;
80104e2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e32:	eb 86                	jmp    80104dba <sys_link+0xda>
80104e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e40 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	57                   	push   %edi
80104e44:	56                   	push   %esi
80104e45:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104e46:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104e49:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104e4c:	50                   	push   %eax
80104e4d:	6a 00                	push   $0x0
80104e4f:	e8 fc f9 ff ff       	call   80104850 <argstr>
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	0f 88 82 01 00 00    	js     80104fe1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104e5f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104e62:	e8 d9 dc ff ff       	call   80102b40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104e67:	83 ec 08             	sub    $0x8,%esp
80104e6a:	53                   	push   %ebx
80104e6b:	ff 75 c0             	pushl  -0x40(%ebp)
80104e6e:	e8 5d d0 ff ff       	call   80101ed0 <nameiparent>
80104e73:	83 c4 10             	add    $0x10,%esp
80104e76:	85 c0                	test   %eax,%eax
80104e78:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104e7b:	0f 84 6a 01 00 00    	je     80104feb <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104e81:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104e84:	83 ec 0c             	sub    $0xc,%esp
80104e87:	56                   	push   %esi
80104e88:	e8 d3 c7 ff ff       	call   80101660 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104e8d:	58                   	pop    %eax
80104e8e:	5a                   	pop    %edx
80104e8f:	68 b8 76 10 80       	push   $0x801076b8
80104e94:	53                   	push   %ebx
80104e95:	e8 d6 cc ff ff       	call   80101b70 <namecmp>
80104e9a:	83 c4 10             	add    $0x10,%esp
80104e9d:	85 c0                	test   %eax,%eax
80104e9f:	0f 84 fc 00 00 00    	je     80104fa1 <sys_unlink+0x161>
80104ea5:	83 ec 08             	sub    $0x8,%esp
80104ea8:	68 b7 76 10 80       	push   $0x801076b7
80104ead:	53                   	push   %ebx
80104eae:	e8 bd cc ff ff       	call   80101b70 <namecmp>
80104eb3:	83 c4 10             	add    $0x10,%esp
80104eb6:	85 c0                	test   %eax,%eax
80104eb8:	0f 84 e3 00 00 00    	je     80104fa1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104ebe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ec1:	83 ec 04             	sub    $0x4,%esp
80104ec4:	50                   	push   %eax
80104ec5:	53                   	push   %ebx
80104ec6:	56                   	push   %esi
80104ec7:	e8 c4 cc ff ff       	call   80101b90 <dirlookup>
80104ecc:	83 c4 10             	add    $0x10,%esp
80104ecf:	85 c0                	test   %eax,%eax
80104ed1:	89 c3                	mov    %eax,%ebx
80104ed3:	0f 84 c8 00 00 00    	je     80104fa1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104ed9:	83 ec 0c             	sub    $0xc,%esp
80104edc:	50                   	push   %eax
80104edd:	e8 7e c7 ff ff       	call   80101660 <ilock>

  if(ip->nlink < 1)
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104eea:	0f 8e 24 01 00 00    	jle    80105014 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ef0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ef5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104ef8:	74 66                	je     80104f60 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104efa:	83 ec 04             	sub    $0x4,%esp
80104efd:	6a 10                	push   $0x10
80104eff:	6a 00                	push   $0x0
80104f01:	56                   	push   %esi
80104f02:	e8 89 f5 ff ff       	call   80104490 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f07:	6a 10                	push   $0x10
80104f09:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f0c:	56                   	push   %esi
80104f0d:	ff 75 b4             	pushl  -0x4c(%ebp)
80104f10:	e8 2b cb ff ff       	call   80101a40 <writei>
80104f15:	83 c4 20             	add    $0x20,%esp
80104f18:	83 f8 10             	cmp    $0x10,%eax
80104f1b:	0f 85 e6 00 00 00    	jne    80105007 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104f21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f26:	0f 84 9c 00 00 00    	je     80104fc8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104f2c:	83 ec 0c             	sub    $0xc,%esp
80104f2f:	ff 75 b4             	pushl  -0x4c(%ebp)
80104f32:	e8 b9 c9 ff ff       	call   801018f0 <iunlockput>

  ip->nlink--;
80104f37:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f3c:	89 1c 24             	mov    %ebx,(%esp)
80104f3f:	e8 6c c6 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80104f44:	89 1c 24             	mov    %ebx,(%esp)
80104f47:	e8 a4 c9 ff ff       	call   801018f0 <iunlockput>

  end_op();
80104f4c:	e8 5f dc ff ff       	call   80102bb0 <end_op>

  return 0;
80104f51:	83 c4 10             	add    $0x10,%esp
80104f54:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104f56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f59:	5b                   	pop    %ebx
80104f5a:	5e                   	pop    %esi
80104f5b:	5f                   	pop    %edi
80104f5c:	5d                   	pop    %ebp
80104f5d:	c3                   	ret    
80104f5e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104f60:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104f64:	76 94                	jbe    80104efa <sys_unlink+0xba>
80104f66:	bf 20 00 00 00       	mov    $0x20,%edi
80104f6b:	eb 0f                	jmp    80104f7c <sys_unlink+0x13c>
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
80104f70:	83 c7 10             	add    $0x10,%edi
80104f73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104f76:	0f 83 7e ff ff ff    	jae    80104efa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f7c:	6a 10                	push   $0x10
80104f7e:	57                   	push   %edi
80104f7f:	56                   	push   %esi
80104f80:	53                   	push   %ebx
80104f81:	e8 ba c9 ff ff       	call   80101940 <readi>
80104f86:	83 c4 10             	add    $0x10,%esp
80104f89:	83 f8 10             	cmp    $0x10,%eax
80104f8c:	75 6c                	jne    80104ffa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104f8e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104f93:	74 db                	je     80104f70 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	53                   	push   %ebx
80104f99:	e8 52 c9 ff ff       	call   801018f0 <iunlockput>
    goto bad;
80104f9e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104fa1:	83 ec 0c             	sub    $0xc,%esp
80104fa4:	ff 75 b4             	pushl  -0x4c(%ebp)
80104fa7:	e8 44 c9 ff ff       	call   801018f0 <iunlockput>
  end_op();
80104fac:	e8 ff db ff ff       	call   80102bb0 <end_op>
  return -1;
80104fb1:	83 c4 10             	add    $0x10,%esp
}
80104fb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104fb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fbc:	5b                   	pop    %ebx
80104fbd:	5e                   	pop    %esi
80104fbe:	5f                   	pop    %edi
80104fbf:	5d                   	pop    %ebp
80104fc0:	c3                   	ret    
80104fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104fc8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80104fcb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104fce:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104fd3:	50                   	push   %eax
80104fd4:	e8 d7 c5 ff ff       	call   801015b0 <iupdate>
80104fd9:	83 c4 10             	add    $0x10,%esp
80104fdc:	e9 4b ff ff ff       	jmp    80104f2c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80104fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe6:	e9 6b ff ff ff       	jmp    80104f56 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80104feb:	e8 c0 db ff ff       	call   80102bb0 <end_op>
    return -1;
80104ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ff5:	e9 5c ff ff ff       	jmp    80104f56 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104ffa:	83 ec 0c             	sub    $0xc,%esp
80104ffd:	68 dc 76 10 80       	push   $0x801076dc
80105002:	e8 69 b3 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105007:	83 ec 0c             	sub    $0xc,%esp
8010500a:	68 ee 76 10 80       	push   $0x801076ee
8010500f:	e8 5c b3 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105014:	83 ec 0c             	sub    $0xc,%esp
80105017:	68 ca 76 10 80       	push   $0x801076ca
8010501c:	e8 4f b3 ff ff       	call   80100370 <panic>
80105021:	eb 0d                	jmp    80105030 <sys_open>
80105023:	90                   	nop
80105024:	90                   	nop
80105025:	90                   	nop
80105026:	90                   	nop
80105027:	90                   	nop
80105028:	90                   	nop
80105029:	90                   	nop
8010502a:	90                   	nop
8010502b:	90                   	nop
8010502c:	90                   	nop
8010502d:	90                   	nop
8010502e:	90                   	nop
8010502f:	90                   	nop

80105030 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105036:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105039:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010503c:	50                   	push   %eax
8010503d:	6a 00                	push   $0x0
8010503f:	e8 0c f8 ff ff       	call   80104850 <argstr>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	85 c0                	test   %eax,%eax
80105049:	0f 88 9e 00 00 00    	js     801050ed <sys_open+0xbd>
8010504f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105052:	83 ec 08             	sub    $0x8,%esp
80105055:	50                   	push   %eax
80105056:	6a 01                	push   $0x1
80105058:	e8 43 f7 ff ff       	call   801047a0 <argint>
8010505d:	83 c4 10             	add    $0x10,%esp
80105060:	85 c0                	test   %eax,%eax
80105062:	0f 88 85 00 00 00    	js     801050ed <sys_open+0xbd>
    return -1;

  begin_op();
80105068:	e8 d3 da ff ff       	call   80102b40 <begin_op>

  if(omode & O_CREATE){
8010506d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105071:	0f 85 89 00 00 00    	jne    80105100 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105077:	83 ec 0c             	sub    $0xc,%esp
8010507a:	ff 75 e0             	pushl  -0x20(%ebp)
8010507d:	e8 2e ce ff ff       	call   80101eb0 <namei>
80105082:	83 c4 10             	add    $0x10,%esp
80105085:	85 c0                	test   %eax,%eax
80105087:	89 c6                	mov    %eax,%esi
80105089:	0f 84 8e 00 00 00    	je     8010511d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	50                   	push   %eax
80105093:	e8 c8 c5 ff ff       	call   80101660 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105098:	83 c4 10             	add    $0x10,%esp
8010509b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801050a0:	0f 84 d2 00 00 00    	je     80105178 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801050a6:	e8 c5 bc ff ff       	call   80100d70 <filealloc>
801050ab:	85 c0                	test   %eax,%eax
801050ad:	89 c7                	mov    %eax,%edi
801050af:	74 2b                	je     801050dc <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801050b1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801050b3:	e8 b8 e6 ff ff       	call   80103770 <myproc>
801050b8:	90                   	nop
801050b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801050c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801050c4:	85 d2                	test   %edx,%edx
801050c6:	74 68                	je     80105130 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801050c8:	83 c3 01             	add    $0x1,%ebx
801050cb:	83 fb 10             	cmp    $0x10,%ebx
801050ce:	75 f0                	jne    801050c0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801050d0:	83 ec 0c             	sub    $0xc,%esp
801050d3:	57                   	push   %edi
801050d4:	e8 57 bd ff ff       	call   80100e30 <fileclose>
801050d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801050dc:	83 ec 0c             	sub    $0xc,%esp
801050df:	56                   	push   %esi
801050e0:	e8 0b c8 ff ff       	call   801018f0 <iunlockput>
    end_op();
801050e5:	e8 c6 da ff ff       	call   80102bb0 <end_op>
    return -1;
801050ea:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801050ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801050f5:	5b                   	pop    %ebx
801050f6:	5e                   	pop    %esi
801050f7:	5f                   	pop    %edi
801050f8:	5d                   	pop    %ebp
801050f9:	c3                   	ret    
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105100:	83 ec 0c             	sub    $0xc,%esp
80105103:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105106:	31 c9                	xor    %ecx,%ecx
80105108:	6a 00                	push   $0x0
8010510a:	ba 02 00 00 00       	mov    $0x2,%edx
8010510f:	e8 dc f7 ff ff       	call   801048f0 <create>
    if(ip == 0){
80105114:	83 c4 10             	add    $0x10,%esp
80105117:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105119:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010511b:	75 89                	jne    801050a6 <sys_open+0x76>
      end_op();
8010511d:	e8 8e da ff ff       	call   80102bb0 <end_op>
      return -1;
80105122:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105127:	eb 43                	jmp    8010516c <sys_open+0x13c>
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105130:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105133:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105137:	56                   	push   %esi
80105138:	e8 03 c6 ff ff       	call   80101740 <iunlock>
  end_op();
8010513d:	e8 6e da ff ff       	call   80102bb0 <end_op>

  f->type = FD_INODE;
80105142:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105148:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010514b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010514e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105151:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105158:	89 d0                	mov    %edx,%eax
8010515a:	83 e0 01             	and    $0x1,%eax
8010515d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105160:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105163:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105166:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010516a:	89 d8                	mov    %ebx,%eax
}
8010516c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010516f:	5b                   	pop    %ebx
80105170:	5e                   	pop    %esi
80105171:	5f                   	pop    %edi
80105172:	5d                   	pop    %ebp
80105173:	c3                   	ret    
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105178:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010517b:	85 c9                	test   %ecx,%ecx
8010517d:	0f 84 23 ff ff ff    	je     801050a6 <sys_open+0x76>
80105183:	e9 54 ff ff ff       	jmp    801050dc <sys_open+0xac>
80105188:	90                   	nop
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105190 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105196:	e8 a5 d9 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010519b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010519e:	83 ec 08             	sub    $0x8,%esp
801051a1:	50                   	push   %eax
801051a2:	6a 00                	push   $0x0
801051a4:	e8 a7 f6 ff ff       	call   80104850 <argstr>
801051a9:	83 c4 10             	add    $0x10,%esp
801051ac:	85 c0                	test   %eax,%eax
801051ae:	78 30                	js     801051e0 <sys_mkdir+0x50>
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051b6:	31 c9                	xor    %ecx,%ecx
801051b8:	6a 00                	push   $0x0
801051ba:	ba 01 00 00 00       	mov    $0x1,%edx
801051bf:	e8 2c f7 ff ff       	call   801048f0 <create>
801051c4:	83 c4 10             	add    $0x10,%esp
801051c7:	85 c0                	test   %eax,%eax
801051c9:	74 15                	je     801051e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801051cb:	83 ec 0c             	sub    $0xc,%esp
801051ce:	50                   	push   %eax
801051cf:	e8 1c c7 ff ff       	call   801018f0 <iunlockput>
  end_op();
801051d4:	e8 d7 d9 ff ff       	call   80102bb0 <end_op>
  return 0;
801051d9:	83 c4 10             	add    $0x10,%esp
801051dc:	31 c0                	xor    %eax,%eax
}
801051de:	c9                   	leave  
801051df:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801051e0:	e8 cb d9 ff ff       	call   80102bb0 <end_op>
    return -1;
801051e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801051ea:	c9                   	leave  
801051eb:	c3                   	ret    
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051f0 <sys_mknod>:

int
sys_mknod(void)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801051f6:	e8 45 d9 ff ff       	call   80102b40 <begin_op>
  if((argstr(0, &path)) < 0 ||
801051fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801051fe:	83 ec 08             	sub    $0x8,%esp
80105201:	50                   	push   %eax
80105202:	6a 00                	push   $0x0
80105204:	e8 47 f6 ff ff       	call   80104850 <argstr>
80105209:	83 c4 10             	add    $0x10,%esp
8010520c:	85 c0                	test   %eax,%eax
8010520e:	78 60                	js     80105270 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105210:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105213:	83 ec 08             	sub    $0x8,%esp
80105216:	50                   	push   %eax
80105217:	6a 01                	push   $0x1
80105219:	e8 82 f5 ff ff       	call   801047a0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010521e:	83 c4 10             	add    $0x10,%esp
80105221:	85 c0                	test   %eax,%eax
80105223:	78 4b                	js     80105270 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105225:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105228:	83 ec 08             	sub    $0x8,%esp
8010522b:	50                   	push   %eax
8010522c:	6a 02                	push   $0x2
8010522e:	e8 6d f5 ff ff       	call   801047a0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105233:	83 c4 10             	add    $0x10,%esp
80105236:	85 c0                	test   %eax,%eax
80105238:	78 36                	js     80105270 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010523a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010523e:	83 ec 0c             	sub    $0xc,%esp
80105241:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105245:	ba 03 00 00 00       	mov    $0x3,%edx
8010524a:	50                   	push   %eax
8010524b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010524e:	e8 9d f6 ff ff       	call   801048f0 <create>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	74 16                	je     80105270 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010525a:	83 ec 0c             	sub    $0xc,%esp
8010525d:	50                   	push   %eax
8010525e:	e8 8d c6 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105263:	e8 48 d9 ff ff       	call   80102bb0 <end_op>
  return 0;
80105268:	83 c4 10             	add    $0x10,%esp
8010526b:	31 c0                	xor    %eax,%eax
}
8010526d:	c9                   	leave  
8010526e:	c3                   	ret    
8010526f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105270:	e8 3b d9 ff ff       	call   80102bb0 <end_op>
    return -1;
80105275:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010527a:	c9                   	leave  
8010527b:	c3                   	ret    
8010527c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105280 <sys_chdir>:

int
sys_chdir(void)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	56                   	push   %esi
80105284:	53                   	push   %ebx
80105285:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105288:	e8 e3 e4 ff ff       	call   80103770 <myproc>
8010528d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010528f:	e8 ac d8 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105294:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105297:	83 ec 08             	sub    $0x8,%esp
8010529a:	50                   	push   %eax
8010529b:	6a 00                	push   $0x0
8010529d:	e8 ae f5 ff ff       	call   80104850 <argstr>
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	85 c0                	test   %eax,%eax
801052a7:	78 77                	js     80105320 <sys_chdir+0xa0>
801052a9:	83 ec 0c             	sub    $0xc,%esp
801052ac:	ff 75 f4             	pushl  -0xc(%ebp)
801052af:	e8 fc cb ff ff       	call   80101eb0 <namei>
801052b4:	83 c4 10             	add    $0x10,%esp
801052b7:	85 c0                	test   %eax,%eax
801052b9:	89 c3                	mov    %eax,%ebx
801052bb:	74 63                	je     80105320 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801052bd:	83 ec 0c             	sub    $0xc,%esp
801052c0:	50                   	push   %eax
801052c1:	e8 9a c3 ff ff       	call   80101660 <ilock>
  if(ip->type != T_DIR){
801052c6:	83 c4 10             	add    $0x10,%esp
801052c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052ce:	75 30                	jne    80105300 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	53                   	push   %ebx
801052d4:	e8 67 c4 ff ff       	call   80101740 <iunlock>
  iput(curproc->cwd);
801052d9:	58                   	pop    %eax
801052da:	ff 76 68             	pushl  0x68(%esi)
801052dd:	e8 ae c4 ff ff       	call   80101790 <iput>
  end_op();
801052e2:	e8 c9 d8 ff ff       	call   80102bb0 <end_op>
  curproc->cwd = ip;
801052e7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801052ea:	83 c4 10             	add    $0x10,%esp
801052ed:	31 c0                	xor    %eax,%eax
}
801052ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052f2:	5b                   	pop    %ebx
801052f3:	5e                   	pop    %esi
801052f4:	5d                   	pop    %ebp
801052f5:	c3                   	ret    
801052f6:	8d 76 00             	lea    0x0(%esi),%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	53                   	push   %ebx
80105304:	e8 e7 c5 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105309:	e8 a2 d8 ff ff       	call   80102bb0 <end_op>
    return -1;
8010530e:	83 c4 10             	add    $0x10,%esp
80105311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105316:	eb d7                	jmp    801052ef <sys_chdir+0x6f>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105320:	e8 8b d8 ff ff       	call   80102bb0 <end_op>
    return -1;
80105325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010532a:	eb c3                	jmp    801052ef <sys_chdir+0x6f>
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	57                   	push   %edi
80105334:	56                   	push   %esi
80105335:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105336:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010533c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105342:	50                   	push   %eax
80105343:	6a 00                	push   $0x0
80105345:	e8 06 f5 ff ff       	call   80104850 <argstr>
8010534a:	83 c4 10             	add    $0x10,%esp
8010534d:	85 c0                	test   %eax,%eax
8010534f:	78 7f                	js     801053d0 <sys_exec+0xa0>
80105351:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105357:	83 ec 08             	sub    $0x8,%esp
8010535a:	50                   	push   %eax
8010535b:	6a 01                	push   $0x1
8010535d:	e8 3e f4 ff ff       	call   801047a0 <argint>
80105362:	83 c4 10             	add    $0x10,%esp
80105365:	85 c0                	test   %eax,%eax
80105367:	78 67                	js     801053d0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105369:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010536f:	83 ec 04             	sub    $0x4,%esp
80105372:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105378:	68 80 00 00 00       	push   $0x80
8010537d:	6a 00                	push   $0x0
8010537f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105385:	50                   	push   %eax
80105386:	31 db                	xor    %ebx,%ebx
80105388:	e8 03 f1 ff ff       	call   80104490 <memset>
8010538d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105390:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105396:	83 ec 08             	sub    $0x8,%esp
80105399:	57                   	push   %edi
8010539a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010539d:	50                   	push   %eax
8010539e:	e8 5d f3 ff ff       	call   80104700 <fetchint>
801053a3:	83 c4 10             	add    $0x10,%esp
801053a6:	85 c0                	test   %eax,%eax
801053a8:	78 26                	js     801053d0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801053aa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053b0:	85 c0                	test   %eax,%eax
801053b2:	74 2c                	je     801053e0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801053b4:	83 ec 08             	sub    $0x8,%esp
801053b7:	56                   	push   %esi
801053b8:	50                   	push   %eax
801053b9:	e8 82 f3 ff ff       	call   80104740 <fetchstr>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 0b                	js     801053d0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801053c5:	83 c3 01             	add    $0x1,%ebx
801053c8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801053cb:	83 fb 20             	cmp    $0x20,%ebx
801053ce:	75 c0                	jne    80105390 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801053d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801053d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801053d8:	5b                   	pop    %ebx
801053d9:	5e                   	pop    %esi
801053da:	5f                   	pop    %edi
801053db:	5d                   	pop    %ebp
801053dc:	c3                   	ret    
801053dd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801053e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053e6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801053e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801053f0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801053f4:	50                   	push   %eax
801053f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801053fb:	e8 f0 b5 ff ff       	call   801009f0 <exec>
80105400:	83 c4 10             	add    $0x10,%esp
}
80105403:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105406:	5b                   	pop    %ebx
80105407:	5e                   	pop    %esi
80105408:	5f                   	pop    %edi
80105409:	5d                   	pop    %ebp
8010540a:	c3                   	ret    
8010540b:	90                   	nop
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_pipe>:

int
sys_pipe(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	57                   	push   %edi
80105414:	56                   	push   %esi
80105415:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105416:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105419:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010541c:	6a 08                	push   $0x8
8010541e:	50                   	push   %eax
8010541f:	6a 00                	push   $0x0
80105421:	e8 ca f3 ff ff       	call   801047f0 <argptr>
80105426:	83 c4 10             	add    $0x10,%esp
80105429:	85 c0                	test   %eax,%eax
8010542b:	78 4a                	js     80105477 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010542d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105430:	83 ec 08             	sub    $0x8,%esp
80105433:	50                   	push   %eax
80105434:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105437:	50                   	push   %eax
80105438:	e8 a3 dd ff ff       	call   801031e0 <pipealloc>
8010543d:	83 c4 10             	add    $0x10,%esp
80105440:	85 c0                	test   %eax,%eax
80105442:	78 33                	js     80105477 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105444:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105446:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105449:	e8 22 e3 ff ff       	call   80103770 <myproc>
8010544e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105450:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105454:	85 f6                	test   %esi,%esi
80105456:	74 30                	je     80105488 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105458:	83 c3 01             	add    $0x1,%ebx
8010545b:	83 fb 10             	cmp    $0x10,%ebx
8010545e:	75 f0                	jne    80105450 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	ff 75 e0             	pushl  -0x20(%ebp)
80105466:	e8 c5 b9 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010546b:	58                   	pop    %eax
8010546c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010546f:	e8 bc b9 ff ff       	call   80100e30 <fileclose>
    return -1;
80105474:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105477:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010547a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010547f:	5b                   	pop    %ebx
80105480:	5e                   	pop    %esi
80105481:	5f                   	pop    %edi
80105482:	5d                   	pop    %ebp
80105483:	c3                   	ret    
80105484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105488:	8d 73 08             	lea    0x8(%ebx),%esi
8010548b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010548f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105492:	e8 d9 e2 ff ff       	call   80103770 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105497:	31 d2                	xor    %edx,%edx
80105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801054a0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801054a4:	85 c9                	test   %ecx,%ecx
801054a6:	74 18                	je     801054c0 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801054a8:	83 c2 01             	add    $0x1,%edx
801054ab:	83 fa 10             	cmp    $0x10,%edx
801054ae:	75 f0                	jne    801054a0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801054b0:	e8 bb e2 ff ff       	call   80103770 <myproc>
801054b5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801054bc:	00 
801054bd:	eb a1                	jmp    80105460 <sys_pipe+0x50>
801054bf:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801054c0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801054c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054c7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801054c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054cc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
801054cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
801054d2:	31 c0                	xor    %eax,%eax
}
801054d4:	5b                   	pop    %ebx
801054d5:	5e                   	pop    %esi
801054d6:	5f                   	pop    %edi
801054d7:	5d                   	pop    %ebp
801054d8:	c3                   	ret    
801054d9:	66 90                	xchg   %ax,%ax
801054db:	66 90                	xchg   %ax,%ax
801054dd:	66 90                	xchg   %ax,%ax
801054df:	90                   	nop

801054e0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801054e3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801054e4:	e9 27 e4 ff ff       	jmp    80103910 <fork>
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054f0 <sys_exit>:
}

int
sys_exit(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801054f6:	e8 b5 e6 ff ff       	call   80103bb0 <exit>
  return 0;  // not reached
}
801054fb:	31 c0                	xor    %eax,%eax
801054fd:	c9                   	leave  
801054fe:	c3                   	ret    
801054ff:	90                   	nop

80105500 <sys_wait>:

int
sys_wait(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105503:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105504:	e9 e7 e8 ff ff       	jmp    80103df0 <wait>
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_kill>:
}

int
sys_kill(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105516:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105519:	50                   	push   %eax
8010551a:	6a 00                	push   $0x0
8010551c:	e8 7f f2 ff ff       	call   801047a0 <argint>
80105521:	83 c4 10             	add    $0x10,%esp
80105524:	85 c0                	test   %eax,%eax
80105526:	78 18                	js     80105540 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105528:	83 ec 0c             	sub    $0xc,%esp
8010552b:	ff 75 f4             	pushl  -0xc(%ebp)
8010552e:	e8 0d ea ff ff       	call   80103f40 <kill>
80105533:	83 c4 10             	add    $0x10,%esp
}
80105536:	c9                   	leave  
80105537:	c3                   	ret    
80105538:	90                   	nop
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <sys_getpid>:

int
sys_getpid(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105556:	e8 15 e2 ff ff       	call   80103770 <myproc>
8010555b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010555e:	c9                   	leave  
8010555f:	c3                   	ret    

80105560 <sys_sbrk>:

int
sys_sbrk(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105564:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105567:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010556a:	50                   	push   %eax
8010556b:	6a 00                	push   $0x0
8010556d:	e8 2e f2 ff ff       	call   801047a0 <argint>
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	85 c0                	test   %eax,%eax
80105577:	78 27                	js     801055a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105579:	e8 f2 e1 ff ff       	call   80103770 <myproc>
  if(growproc(n) < 0)
8010557e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105581:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105583:	ff 75 f4             	pushl  -0xc(%ebp)
80105586:	e8 05 e3 ff ff       	call   80103890 <growproc>
8010558b:	83 c4 10             	add    $0x10,%esp
8010558e:	85 c0                	test   %eax,%eax
80105590:	78 0e                	js     801055a0 <sys_sbrk+0x40>
    return -1;
  return addr;
80105592:	89 d8                	mov    %ebx,%eax
}
80105594:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105597:	c9                   	leave  
80105598:	c3                   	ret    
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801055a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a5:	eb ed                	jmp    80105594 <sys_sbrk+0x34>
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801055b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801055b7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801055ba:	50                   	push   %eax
801055bb:	6a 00                	push   $0x0
801055bd:	e8 de f1 ff ff       	call   801047a0 <argint>
801055c2:	83 c4 10             	add    $0x10,%esp
801055c5:	85 c0                	test   %eax,%eax
801055c7:	0f 88 8a 00 00 00    	js     80105657 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801055cd:	83 ec 0c             	sub    $0xc,%esp
801055d0:	68 60 4d 11 80       	push   $0x80114d60
801055d5:	e8 b6 ed ff ff       	call   80104390 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801055da:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055dd:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801055e0:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  while(ticks - ticks0 < n){
801055e6:	85 d2                	test   %edx,%edx
801055e8:	75 27                	jne    80105611 <sys_sleep+0x61>
801055ea:	eb 54                	jmp    80105640 <sys_sleep+0x90>
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801055f0:	83 ec 08             	sub    $0x8,%esp
801055f3:	68 60 4d 11 80       	push   $0x80114d60
801055f8:	68 a0 55 11 80       	push   $0x801155a0
801055fd:	e8 2e e7 ff ff       	call   80103d30 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105602:	a1 a0 55 11 80       	mov    0x801155a0,%eax
80105607:	83 c4 10             	add    $0x10,%esp
8010560a:	29 d8                	sub    %ebx,%eax
8010560c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010560f:	73 2f                	jae    80105640 <sys_sleep+0x90>
    if(myproc()->killed){
80105611:	e8 5a e1 ff ff       	call   80103770 <myproc>
80105616:	8b 40 24             	mov    0x24(%eax),%eax
80105619:	85 c0                	test   %eax,%eax
8010561b:	74 d3                	je     801055f0 <sys_sleep+0x40>
      release(&tickslock);
8010561d:	83 ec 0c             	sub    $0xc,%esp
80105620:	68 60 4d 11 80       	push   $0x80114d60
80105625:	e8 16 ee ff ff       	call   80104440 <release>
      return -1;
8010562a:	83 c4 10             	add    $0x10,%esp
8010562d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105632:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105635:	c9                   	leave  
80105636:	c3                   	ret    
80105637:	89 f6                	mov    %esi,%esi
80105639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105640:	83 ec 0c             	sub    $0xc,%esp
80105643:	68 60 4d 11 80       	push   $0x80114d60
80105648:	e8 f3 ed ff ff       	call   80104440 <release>
  return 0;
8010564d:	83 c4 10             	add    $0x10,%esp
80105650:	31 c0                	xor    %eax,%eax
}
80105652:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105655:	c9                   	leave  
80105656:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105657:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010565c:	eb d4                	jmp    80105632 <sys_sleep+0x82>
8010565e:	66 90                	xchg   %ax,%ax

80105660 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	53                   	push   %ebx
80105664:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105667:	68 60 4d 11 80       	push   $0x80114d60
8010566c:	e8 1f ed ff ff       	call   80104390 <acquire>
  xticks = ticks;
80105671:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  release(&tickslock);
80105677:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
8010567e:	e8 bd ed ff ff       	call   80104440 <release>
  return xticks;
}
80105683:	89 d8                	mov    %ebx,%eax
80105685:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105688:	c9                   	leave  
80105689:	c3                   	ret    
8010568a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105690 <sys_cps>:

//dumps ptable onto proc.dump file
int
sys_cps(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
 return cps();
}
80105693:	5d                   	pop    %ebp

//dumps ptable onto proc.dump file
int
sys_cps(void)
{
 return cps();
80105694:	e9 f7 e9 ff ff       	jmp    80104090 <cps>

80105699 <alltraps>:
80105699:	1e                   	push   %ds
8010569a:	06                   	push   %es
8010569b:	0f a0                	push   %fs
8010569d:	0f a8                	push   %gs
8010569f:	60                   	pusha  
801056a0:	66 b8 10 00          	mov    $0x10,%ax
801056a4:	8e d8                	mov    %eax,%ds
801056a6:	8e c0                	mov    %eax,%es
801056a8:	54                   	push   %esp
801056a9:	e8 e2 00 00 00       	call   80105790 <trap>
801056ae:	83 c4 04             	add    $0x4,%esp

801056b1 <trapret>:
801056b1:	61                   	popa   
801056b2:	0f a9                	pop    %gs
801056b4:	0f a1                	pop    %fs
801056b6:	07                   	pop    %es
801056b7:	1f                   	pop    %ds
801056b8:	83 c4 08             	add    $0x8,%esp
801056bb:	cf                   	iret   
801056bc:	66 90                	xchg   %ax,%ax
801056be:	66 90                	xchg   %ax,%ax

801056c0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801056c0:	31 c0                	xor    %eax,%eax
801056c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801056c8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801056cf:	b9 08 00 00 00       	mov    $0x8,%ecx
801056d4:	c6 04 c5 a4 4d 11 80 	movb   $0x0,-0x7feeb25c(,%eax,8)
801056db:	00 
801056dc:	66 89 0c c5 a2 4d 11 	mov    %cx,-0x7feeb25e(,%eax,8)
801056e3:	80 
801056e4:	c6 04 c5 a5 4d 11 80 	movb   $0x8e,-0x7feeb25b(,%eax,8)
801056eb:	8e 
801056ec:	66 89 14 c5 a0 4d 11 	mov    %dx,-0x7feeb260(,%eax,8)
801056f3:	80 
801056f4:	c1 ea 10             	shr    $0x10,%edx
801056f7:	66 89 14 c5 a6 4d 11 	mov    %dx,-0x7feeb25a(,%eax,8)
801056fe:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801056ff:	83 c0 01             	add    $0x1,%eax
80105702:	3d 00 01 00 00       	cmp    $0x100,%eax
80105707:	75 bf                	jne    801056c8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105709:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010570a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010570f:	89 e5                	mov    %esp,%ebp
80105711:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105714:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105719:	68 fd 76 10 80       	push   $0x801076fd
8010571e:	68 60 4d 11 80       	push   $0x80114d60
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105723:	66 89 15 a2 4f 11 80 	mov    %dx,0x80114fa2
8010572a:	c6 05 a4 4f 11 80 00 	movb   $0x0,0x80114fa4
80105731:	66 a3 a0 4f 11 80    	mov    %ax,0x80114fa0
80105737:	c1 e8 10             	shr    $0x10,%eax
8010573a:	c6 05 a5 4f 11 80 ef 	movb   $0xef,0x80114fa5
80105741:	66 a3 a6 4f 11 80    	mov    %ax,0x80114fa6

  initlock(&tickslock, "time");
80105747:	e8 e4 ea ff ff       	call   80104230 <initlock>
}
8010574c:	83 c4 10             	add    $0x10,%esp
8010574f:	c9                   	leave  
80105750:	c3                   	ret    
80105751:	eb 0d                	jmp    80105760 <idtinit>
80105753:	90                   	nop
80105754:	90                   	nop
80105755:	90                   	nop
80105756:	90                   	nop
80105757:	90                   	nop
80105758:	90                   	nop
80105759:	90                   	nop
8010575a:	90                   	nop
8010575b:	90                   	nop
8010575c:	90                   	nop
8010575d:	90                   	nop
8010575e:	90                   	nop
8010575f:	90                   	nop

80105760 <idtinit>:

void
idtinit(void)
{
80105760:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105761:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105766:	89 e5                	mov    %esp,%ebp
80105768:	83 ec 10             	sub    $0x10,%esp
8010576b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010576f:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
80105774:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105778:	c1 e8 10             	shr    $0x10,%eax
8010577b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010577f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105782:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105785:	c9                   	leave  
80105786:	c3                   	ret    
80105787:	89 f6                	mov    %esi,%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105790 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	57                   	push   %edi
80105794:	56                   	push   %esi
80105795:	53                   	push   %ebx
80105796:	83 ec 1c             	sub    $0x1c,%esp
80105799:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010579c:	8b 47 30             	mov    0x30(%edi),%eax
8010579f:	83 f8 40             	cmp    $0x40,%eax
801057a2:	0f 84 88 01 00 00    	je     80105930 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801057a8:	83 e8 20             	sub    $0x20,%eax
801057ab:	83 f8 1f             	cmp    $0x1f,%eax
801057ae:	77 10                	ja     801057c0 <trap+0x30>
801057b0:	ff 24 85 a4 77 10 80 	jmp    *-0x7fef885c(,%eax,4)
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801057c0:	e8 ab df ff ff       	call   80103770 <myproc>
801057c5:	85 c0                	test   %eax,%eax
801057c7:	0f 84 d7 01 00 00    	je     801059a4 <trap+0x214>
801057cd:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801057d1:	0f 84 cd 01 00 00    	je     801059a4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801057d7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801057da:	8b 57 38             	mov    0x38(%edi),%edx
801057dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801057e0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801057e3:	e8 68 df ff ff       	call   80103750 <cpuid>
801057e8:	8b 77 34             	mov    0x34(%edi),%esi
801057eb:	8b 5f 30             	mov    0x30(%edi),%ebx
801057ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801057f1:	e8 7a df ff ff       	call   80103770 <myproc>
801057f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801057f9:	e8 72 df ff ff       	call   80103770 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801057fe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105801:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105804:	51                   	push   %ecx
80105805:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105806:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105809:	ff 75 e4             	pushl  -0x1c(%ebp)
8010580c:	56                   	push   %esi
8010580d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010580e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105811:	52                   	push   %edx
80105812:	ff 70 10             	pushl  0x10(%eax)
80105815:	68 60 77 10 80       	push   $0x80107760
8010581a:	e8 41 ae ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010581f:	83 c4 20             	add    $0x20,%esp
80105822:	e8 49 df ff ff       	call   80103770 <myproc>
80105827:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010582e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105830:	e8 3b df ff ff       	call   80103770 <myproc>
80105835:	85 c0                	test   %eax,%eax
80105837:	74 0c                	je     80105845 <trap+0xb5>
80105839:	e8 32 df ff ff       	call   80103770 <myproc>
8010583e:	8b 50 24             	mov    0x24(%eax),%edx
80105841:	85 d2                	test   %edx,%edx
80105843:	75 4b                	jne    80105890 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105845:	e8 26 df ff ff       	call   80103770 <myproc>
8010584a:	85 c0                	test   %eax,%eax
8010584c:	74 0b                	je     80105859 <trap+0xc9>
8010584e:	e8 1d df ff ff       	call   80103770 <myproc>
80105853:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105857:	74 4f                	je     801058a8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105859:	e8 12 df ff ff       	call   80103770 <myproc>
8010585e:	85 c0                	test   %eax,%eax
80105860:	74 1d                	je     8010587f <trap+0xef>
80105862:	e8 09 df ff ff       	call   80103770 <myproc>
80105867:	8b 40 24             	mov    0x24(%eax),%eax
8010586a:	85 c0                	test   %eax,%eax
8010586c:	74 11                	je     8010587f <trap+0xef>
8010586e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105872:	83 e0 03             	and    $0x3,%eax
80105875:	66 83 f8 03          	cmp    $0x3,%ax
80105879:	0f 84 da 00 00 00    	je     80105959 <trap+0x1c9>
    exit();
}
8010587f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105882:	5b                   	pop    %ebx
80105883:	5e                   	pop    %esi
80105884:	5f                   	pop    %edi
80105885:	5d                   	pop    %ebp
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105890:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105894:	83 e0 03             	and    $0x3,%eax
80105897:	66 83 f8 03          	cmp    $0x3,%ax
8010589b:	75 a8                	jne    80105845 <trap+0xb5>
    exit();
8010589d:	e8 0e e3 ff ff       	call   80103bb0 <exit>
801058a2:	eb a1                	jmp    80105845 <trap+0xb5>
801058a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801058a8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801058ac:	75 ab                	jne    80105859 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
801058ae:	e8 2d e4 ff ff       	call   80103ce0 <yield>
801058b3:	eb a4                	jmp    80105859 <trap+0xc9>
801058b5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801058b8:	e8 93 de ff ff       	call   80103750 <cpuid>
801058bd:	85 c0                	test   %eax,%eax
801058bf:	0f 84 ab 00 00 00    	je     80105970 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801058c5:	e8 36 ce ff ff       	call   80102700 <lapiceoi>
    break;
801058ca:	e9 61 ff ff ff       	jmp    80105830 <trap+0xa0>
801058cf:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801058d0:	e8 eb cc ff ff       	call   801025c0 <kbdintr>
    lapiceoi();
801058d5:	e8 26 ce ff ff       	call   80102700 <lapiceoi>
    break;
801058da:	e9 51 ff ff ff       	jmp    80105830 <trap+0xa0>
801058df:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801058e0:	e8 5b 02 00 00       	call   80105b40 <uartintr>
    lapiceoi();
801058e5:	e8 16 ce ff ff       	call   80102700 <lapiceoi>
    break;
801058ea:	e9 41 ff ff ff       	jmp    80105830 <trap+0xa0>
801058ef:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801058f0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
801058f4:	8b 77 38             	mov    0x38(%edi),%esi
801058f7:	e8 54 de ff ff       	call   80103750 <cpuid>
801058fc:	56                   	push   %esi
801058fd:	53                   	push   %ebx
801058fe:	50                   	push   %eax
801058ff:	68 08 77 10 80       	push   $0x80107708
80105904:	e8 57 ad ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105909:	e8 f2 cd ff ff       	call   80102700 <lapiceoi>
    break;
8010590e:	83 c4 10             	add    $0x10,%esp
80105911:	e9 1a ff ff ff       	jmp    80105830 <trap+0xa0>
80105916:	8d 76 00             	lea    0x0(%esi),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105920:	e8 1b c7 ff ff       	call   80102040 <ideintr>
80105925:	eb 9e                	jmp    801058c5 <trap+0x135>
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105930:	e8 3b de ff ff       	call   80103770 <myproc>
80105935:	8b 58 24             	mov    0x24(%eax),%ebx
80105938:	85 db                	test   %ebx,%ebx
8010593a:	75 2c                	jne    80105968 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
8010593c:	e8 2f de ff ff       	call   80103770 <myproc>
80105941:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105944:	e8 47 ef ff ff       	call   80104890 <syscall>
    if(myproc()->killed)
80105949:	e8 22 de ff ff       	call   80103770 <myproc>
8010594e:	8b 48 24             	mov    0x24(%eax),%ecx
80105951:	85 c9                	test   %ecx,%ecx
80105953:	0f 84 26 ff ff ff    	je     8010587f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105959:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010595c:	5b                   	pop    %ebx
8010595d:	5e                   	pop    %esi
8010595e:	5f                   	pop    %edi
8010595f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105960:	e9 4b e2 ff ff       	jmp    80103bb0 <exit>
80105965:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105968:	e8 43 e2 ff ff       	call   80103bb0 <exit>
8010596d:	eb cd                	jmp    8010593c <trap+0x1ac>
8010596f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105970:	83 ec 0c             	sub    $0xc,%esp
80105973:	68 60 4d 11 80       	push   $0x80114d60
80105978:	e8 13 ea ff ff       	call   80104390 <acquire>
      ticks++;
      wakeup(&ticks);
8010597d:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105984:	83 05 a0 55 11 80 01 	addl   $0x1,0x801155a0
      wakeup(&ticks);
8010598b:	e8 50 e5 ff ff       	call   80103ee0 <wakeup>
      release(&tickslock);
80105990:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105997:	e8 a4 ea ff ff       	call   80104440 <release>
8010599c:	83 c4 10             	add    $0x10,%esp
8010599f:	e9 21 ff ff ff       	jmp    801058c5 <trap+0x135>
801059a4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801059a7:	8b 5f 38             	mov    0x38(%edi),%ebx
801059aa:	e8 a1 dd ff ff       	call   80103750 <cpuid>
801059af:	83 ec 0c             	sub    $0xc,%esp
801059b2:	56                   	push   %esi
801059b3:	53                   	push   %ebx
801059b4:	50                   	push   %eax
801059b5:	ff 77 30             	pushl  0x30(%edi)
801059b8:	68 2c 77 10 80       	push   $0x8010772c
801059bd:	e8 9e ac ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801059c2:	83 c4 14             	add    $0x14,%esp
801059c5:	68 02 77 10 80       	push   $0x80107702
801059ca:	e8 a1 a9 ff ff       	call   80100370 <panic>
801059cf:	90                   	nop

801059d0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801059d0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801059d5:	55                   	push   %ebp
801059d6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801059d8:	85 c0                	test   %eax,%eax
801059da:	74 1c                	je     801059f8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801059dc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801059e1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801059e2:	a8 01                	test   $0x1,%al
801059e4:	74 12                	je     801059f8 <uartgetc+0x28>
801059e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801059eb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801059ec:	0f b6 c0             	movzbl %al,%eax
}
801059ef:	5d                   	pop    %ebp
801059f0:	c3                   	ret    
801059f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801059f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801059fd:	5d                   	pop    %ebp
801059fe:	c3                   	ret    
801059ff:	90                   	nop

80105a00 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	56                   	push   %esi
80105a05:	53                   	push   %ebx
80105a06:	89 c7                	mov    %eax,%edi
80105a08:	bb 80 00 00 00       	mov    $0x80,%ebx
80105a0d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a12:	83 ec 0c             	sub    $0xc,%esp
80105a15:	eb 1b                	jmp    80105a32 <uartputc.part.0+0x32>
80105a17:	89 f6                	mov    %esi,%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105a20:	83 ec 0c             	sub    $0xc,%esp
80105a23:	6a 0a                	push   $0xa
80105a25:	e8 f6 cc ff ff       	call   80102720 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a2a:	83 c4 10             	add    $0x10,%esp
80105a2d:	83 eb 01             	sub    $0x1,%ebx
80105a30:	74 07                	je     80105a39 <uartputc.part.0+0x39>
80105a32:	89 f2                	mov    %esi,%edx
80105a34:	ec                   	in     (%dx),%al
80105a35:	a8 20                	test   $0x20,%al
80105a37:	74 e7                	je     80105a20 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a39:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a3e:	89 f8                	mov    %edi,%eax
80105a40:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a44:	5b                   	pop    %ebx
80105a45:	5e                   	pop    %esi
80105a46:	5f                   	pop    %edi
80105a47:	5d                   	pop    %ebp
80105a48:	c3                   	ret    
80105a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a50 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105a50:	55                   	push   %ebp
80105a51:	31 c9                	xor    %ecx,%ecx
80105a53:	89 c8                	mov    %ecx,%eax
80105a55:	89 e5                	mov    %esp,%ebp
80105a57:	57                   	push   %edi
80105a58:	56                   	push   %esi
80105a59:	53                   	push   %ebx
80105a5a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105a5f:	89 da                	mov    %ebx,%edx
80105a61:	83 ec 0c             	sub    $0xc,%esp
80105a64:	ee                   	out    %al,(%dx)
80105a65:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105a6a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105a6f:	89 fa                	mov    %edi,%edx
80105a71:	ee                   	out    %al,(%dx)
80105a72:	b8 0c 00 00 00       	mov    $0xc,%eax
80105a77:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a7c:	ee                   	out    %al,(%dx)
80105a7d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105a82:	89 c8                	mov    %ecx,%eax
80105a84:	89 f2                	mov    %esi,%edx
80105a86:	ee                   	out    %al,(%dx)
80105a87:	b8 03 00 00 00       	mov    $0x3,%eax
80105a8c:	89 fa                	mov    %edi,%edx
80105a8e:	ee                   	out    %al,(%dx)
80105a8f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105a94:	89 c8                	mov    %ecx,%eax
80105a96:	ee                   	out    %al,(%dx)
80105a97:	b8 01 00 00 00       	mov    $0x1,%eax
80105a9c:	89 f2                	mov    %esi,%edx
80105a9e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a9f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105aa4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105aa5:	3c ff                	cmp    $0xff,%al
80105aa7:	74 5a                	je     80105b03 <uartinit+0xb3>
    return;
  uart = 1;
80105aa9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105ab0:	00 00 00 
80105ab3:	89 da                	mov    %ebx,%edx
80105ab5:	ec                   	in     (%dx),%al
80105ab6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105abb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105abc:	83 ec 08             	sub    $0x8,%esp
80105abf:	bb 24 78 10 80       	mov    $0x80107824,%ebx
80105ac4:	6a 00                	push   $0x0
80105ac6:	6a 04                	push   $0x4
80105ac8:	e8 c3 c7 ff ff       	call   80102290 <ioapicenable>
80105acd:	83 c4 10             	add    $0x10,%esp
80105ad0:	b8 78 00 00 00       	mov    $0x78,%eax
80105ad5:	eb 13                	jmp    80105aea <uartinit+0x9a>
80105ad7:	89 f6                	mov    %esi,%esi
80105ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ae0:	83 c3 01             	add    $0x1,%ebx
80105ae3:	0f be 03             	movsbl (%ebx),%eax
80105ae6:	84 c0                	test   %al,%al
80105ae8:	74 19                	je     80105b03 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105aea:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105af0:	85 d2                	test   %edx,%edx
80105af2:	74 ec                	je     80105ae0 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105af4:	83 c3 01             	add    $0x1,%ebx
80105af7:	e8 04 ff ff ff       	call   80105a00 <uartputc.part.0>
80105afc:	0f be 03             	movsbl (%ebx),%eax
80105aff:	84 c0                	test   %al,%al
80105b01:	75 e7                	jne    80105aea <uartinit+0x9a>
    uartputc(*p);
}
80105b03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b06:	5b                   	pop    %ebx
80105b07:	5e                   	pop    %esi
80105b08:	5f                   	pop    %edi
80105b09:	5d                   	pop    %ebp
80105b0a:	c3                   	ret    
80105b0b:	90                   	nop
80105b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b10 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105b10:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b16:	55                   	push   %ebp
80105b17:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105b19:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105b1e:	74 10                	je     80105b30 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105b20:	5d                   	pop    %ebp
80105b21:	e9 da fe ff ff       	jmp    80105a00 <uartputc.part.0>
80105b26:	8d 76 00             	lea    0x0(%esi),%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b30:	5d                   	pop    %ebp
80105b31:	c3                   	ret    
80105b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b40 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105b46:	68 d0 59 10 80       	push   $0x801059d0
80105b4b:	e8 a0 ac ff ff       	call   801007f0 <consoleintr>
}
80105b50:	83 c4 10             	add    $0x10,%esp
80105b53:	c9                   	leave  
80105b54:	c3                   	ret    

80105b55 <vector0>:
80105b55:	6a 00                	push   $0x0
80105b57:	6a 00                	push   $0x0
80105b59:	e9 3b fb ff ff       	jmp    80105699 <alltraps>

80105b5e <vector1>:
80105b5e:	6a 00                	push   $0x0
80105b60:	6a 01                	push   $0x1
80105b62:	e9 32 fb ff ff       	jmp    80105699 <alltraps>

80105b67 <vector2>:
80105b67:	6a 00                	push   $0x0
80105b69:	6a 02                	push   $0x2
80105b6b:	e9 29 fb ff ff       	jmp    80105699 <alltraps>

80105b70 <vector3>:
80105b70:	6a 00                	push   $0x0
80105b72:	6a 03                	push   $0x3
80105b74:	e9 20 fb ff ff       	jmp    80105699 <alltraps>

80105b79 <vector4>:
80105b79:	6a 00                	push   $0x0
80105b7b:	6a 04                	push   $0x4
80105b7d:	e9 17 fb ff ff       	jmp    80105699 <alltraps>

80105b82 <vector5>:
80105b82:	6a 00                	push   $0x0
80105b84:	6a 05                	push   $0x5
80105b86:	e9 0e fb ff ff       	jmp    80105699 <alltraps>

80105b8b <vector6>:
80105b8b:	6a 00                	push   $0x0
80105b8d:	6a 06                	push   $0x6
80105b8f:	e9 05 fb ff ff       	jmp    80105699 <alltraps>

80105b94 <vector7>:
80105b94:	6a 00                	push   $0x0
80105b96:	6a 07                	push   $0x7
80105b98:	e9 fc fa ff ff       	jmp    80105699 <alltraps>

80105b9d <vector8>:
80105b9d:	6a 08                	push   $0x8
80105b9f:	e9 f5 fa ff ff       	jmp    80105699 <alltraps>

80105ba4 <vector9>:
80105ba4:	6a 00                	push   $0x0
80105ba6:	6a 09                	push   $0x9
80105ba8:	e9 ec fa ff ff       	jmp    80105699 <alltraps>

80105bad <vector10>:
80105bad:	6a 0a                	push   $0xa
80105baf:	e9 e5 fa ff ff       	jmp    80105699 <alltraps>

80105bb4 <vector11>:
80105bb4:	6a 0b                	push   $0xb
80105bb6:	e9 de fa ff ff       	jmp    80105699 <alltraps>

80105bbb <vector12>:
80105bbb:	6a 0c                	push   $0xc
80105bbd:	e9 d7 fa ff ff       	jmp    80105699 <alltraps>

80105bc2 <vector13>:
80105bc2:	6a 0d                	push   $0xd
80105bc4:	e9 d0 fa ff ff       	jmp    80105699 <alltraps>

80105bc9 <vector14>:
80105bc9:	6a 0e                	push   $0xe
80105bcb:	e9 c9 fa ff ff       	jmp    80105699 <alltraps>

80105bd0 <vector15>:
80105bd0:	6a 00                	push   $0x0
80105bd2:	6a 0f                	push   $0xf
80105bd4:	e9 c0 fa ff ff       	jmp    80105699 <alltraps>

80105bd9 <vector16>:
80105bd9:	6a 00                	push   $0x0
80105bdb:	6a 10                	push   $0x10
80105bdd:	e9 b7 fa ff ff       	jmp    80105699 <alltraps>

80105be2 <vector17>:
80105be2:	6a 11                	push   $0x11
80105be4:	e9 b0 fa ff ff       	jmp    80105699 <alltraps>

80105be9 <vector18>:
80105be9:	6a 00                	push   $0x0
80105beb:	6a 12                	push   $0x12
80105bed:	e9 a7 fa ff ff       	jmp    80105699 <alltraps>

80105bf2 <vector19>:
80105bf2:	6a 00                	push   $0x0
80105bf4:	6a 13                	push   $0x13
80105bf6:	e9 9e fa ff ff       	jmp    80105699 <alltraps>

80105bfb <vector20>:
80105bfb:	6a 00                	push   $0x0
80105bfd:	6a 14                	push   $0x14
80105bff:	e9 95 fa ff ff       	jmp    80105699 <alltraps>

80105c04 <vector21>:
80105c04:	6a 00                	push   $0x0
80105c06:	6a 15                	push   $0x15
80105c08:	e9 8c fa ff ff       	jmp    80105699 <alltraps>

80105c0d <vector22>:
80105c0d:	6a 00                	push   $0x0
80105c0f:	6a 16                	push   $0x16
80105c11:	e9 83 fa ff ff       	jmp    80105699 <alltraps>

80105c16 <vector23>:
80105c16:	6a 00                	push   $0x0
80105c18:	6a 17                	push   $0x17
80105c1a:	e9 7a fa ff ff       	jmp    80105699 <alltraps>

80105c1f <vector24>:
80105c1f:	6a 00                	push   $0x0
80105c21:	6a 18                	push   $0x18
80105c23:	e9 71 fa ff ff       	jmp    80105699 <alltraps>

80105c28 <vector25>:
80105c28:	6a 00                	push   $0x0
80105c2a:	6a 19                	push   $0x19
80105c2c:	e9 68 fa ff ff       	jmp    80105699 <alltraps>

80105c31 <vector26>:
80105c31:	6a 00                	push   $0x0
80105c33:	6a 1a                	push   $0x1a
80105c35:	e9 5f fa ff ff       	jmp    80105699 <alltraps>

80105c3a <vector27>:
80105c3a:	6a 00                	push   $0x0
80105c3c:	6a 1b                	push   $0x1b
80105c3e:	e9 56 fa ff ff       	jmp    80105699 <alltraps>

80105c43 <vector28>:
80105c43:	6a 00                	push   $0x0
80105c45:	6a 1c                	push   $0x1c
80105c47:	e9 4d fa ff ff       	jmp    80105699 <alltraps>

80105c4c <vector29>:
80105c4c:	6a 00                	push   $0x0
80105c4e:	6a 1d                	push   $0x1d
80105c50:	e9 44 fa ff ff       	jmp    80105699 <alltraps>

80105c55 <vector30>:
80105c55:	6a 00                	push   $0x0
80105c57:	6a 1e                	push   $0x1e
80105c59:	e9 3b fa ff ff       	jmp    80105699 <alltraps>

80105c5e <vector31>:
80105c5e:	6a 00                	push   $0x0
80105c60:	6a 1f                	push   $0x1f
80105c62:	e9 32 fa ff ff       	jmp    80105699 <alltraps>

80105c67 <vector32>:
80105c67:	6a 00                	push   $0x0
80105c69:	6a 20                	push   $0x20
80105c6b:	e9 29 fa ff ff       	jmp    80105699 <alltraps>

80105c70 <vector33>:
80105c70:	6a 00                	push   $0x0
80105c72:	6a 21                	push   $0x21
80105c74:	e9 20 fa ff ff       	jmp    80105699 <alltraps>

80105c79 <vector34>:
80105c79:	6a 00                	push   $0x0
80105c7b:	6a 22                	push   $0x22
80105c7d:	e9 17 fa ff ff       	jmp    80105699 <alltraps>

80105c82 <vector35>:
80105c82:	6a 00                	push   $0x0
80105c84:	6a 23                	push   $0x23
80105c86:	e9 0e fa ff ff       	jmp    80105699 <alltraps>

80105c8b <vector36>:
80105c8b:	6a 00                	push   $0x0
80105c8d:	6a 24                	push   $0x24
80105c8f:	e9 05 fa ff ff       	jmp    80105699 <alltraps>

80105c94 <vector37>:
80105c94:	6a 00                	push   $0x0
80105c96:	6a 25                	push   $0x25
80105c98:	e9 fc f9 ff ff       	jmp    80105699 <alltraps>

80105c9d <vector38>:
80105c9d:	6a 00                	push   $0x0
80105c9f:	6a 26                	push   $0x26
80105ca1:	e9 f3 f9 ff ff       	jmp    80105699 <alltraps>

80105ca6 <vector39>:
80105ca6:	6a 00                	push   $0x0
80105ca8:	6a 27                	push   $0x27
80105caa:	e9 ea f9 ff ff       	jmp    80105699 <alltraps>

80105caf <vector40>:
80105caf:	6a 00                	push   $0x0
80105cb1:	6a 28                	push   $0x28
80105cb3:	e9 e1 f9 ff ff       	jmp    80105699 <alltraps>

80105cb8 <vector41>:
80105cb8:	6a 00                	push   $0x0
80105cba:	6a 29                	push   $0x29
80105cbc:	e9 d8 f9 ff ff       	jmp    80105699 <alltraps>

80105cc1 <vector42>:
80105cc1:	6a 00                	push   $0x0
80105cc3:	6a 2a                	push   $0x2a
80105cc5:	e9 cf f9 ff ff       	jmp    80105699 <alltraps>

80105cca <vector43>:
80105cca:	6a 00                	push   $0x0
80105ccc:	6a 2b                	push   $0x2b
80105cce:	e9 c6 f9 ff ff       	jmp    80105699 <alltraps>

80105cd3 <vector44>:
80105cd3:	6a 00                	push   $0x0
80105cd5:	6a 2c                	push   $0x2c
80105cd7:	e9 bd f9 ff ff       	jmp    80105699 <alltraps>

80105cdc <vector45>:
80105cdc:	6a 00                	push   $0x0
80105cde:	6a 2d                	push   $0x2d
80105ce0:	e9 b4 f9 ff ff       	jmp    80105699 <alltraps>

80105ce5 <vector46>:
80105ce5:	6a 00                	push   $0x0
80105ce7:	6a 2e                	push   $0x2e
80105ce9:	e9 ab f9 ff ff       	jmp    80105699 <alltraps>

80105cee <vector47>:
80105cee:	6a 00                	push   $0x0
80105cf0:	6a 2f                	push   $0x2f
80105cf2:	e9 a2 f9 ff ff       	jmp    80105699 <alltraps>

80105cf7 <vector48>:
80105cf7:	6a 00                	push   $0x0
80105cf9:	6a 30                	push   $0x30
80105cfb:	e9 99 f9 ff ff       	jmp    80105699 <alltraps>

80105d00 <vector49>:
80105d00:	6a 00                	push   $0x0
80105d02:	6a 31                	push   $0x31
80105d04:	e9 90 f9 ff ff       	jmp    80105699 <alltraps>

80105d09 <vector50>:
80105d09:	6a 00                	push   $0x0
80105d0b:	6a 32                	push   $0x32
80105d0d:	e9 87 f9 ff ff       	jmp    80105699 <alltraps>

80105d12 <vector51>:
80105d12:	6a 00                	push   $0x0
80105d14:	6a 33                	push   $0x33
80105d16:	e9 7e f9 ff ff       	jmp    80105699 <alltraps>

80105d1b <vector52>:
80105d1b:	6a 00                	push   $0x0
80105d1d:	6a 34                	push   $0x34
80105d1f:	e9 75 f9 ff ff       	jmp    80105699 <alltraps>

80105d24 <vector53>:
80105d24:	6a 00                	push   $0x0
80105d26:	6a 35                	push   $0x35
80105d28:	e9 6c f9 ff ff       	jmp    80105699 <alltraps>

80105d2d <vector54>:
80105d2d:	6a 00                	push   $0x0
80105d2f:	6a 36                	push   $0x36
80105d31:	e9 63 f9 ff ff       	jmp    80105699 <alltraps>

80105d36 <vector55>:
80105d36:	6a 00                	push   $0x0
80105d38:	6a 37                	push   $0x37
80105d3a:	e9 5a f9 ff ff       	jmp    80105699 <alltraps>

80105d3f <vector56>:
80105d3f:	6a 00                	push   $0x0
80105d41:	6a 38                	push   $0x38
80105d43:	e9 51 f9 ff ff       	jmp    80105699 <alltraps>

80105d48 <vector57>:
80105d48:	6a 00                	push   $0x0
80105d4a:	6a 39                	push   $0x39
80105d4c:	e9 48 f9 ff ff       	jmp    80105699 <alltraps>

80105d51 <vector58>:
80105d51:	6a 00                	push   $0x0
80105d53:	6a 3a                	push   $0x3a
80105d55:	e9 3f f9 ff ff       	jmp    80105699 <alltraps>

80105d5a <vector59>:
80105d5a:	6a 00                	push   $0x0
80105d5c:	6a 3b                	push   $0x3b
80105d5e:	e9 36 f9 ff ff       	jmp    80105699 <alltraps>

80105d63 <vector60>:
80105d63:	6a 00                	push   $0x0
80105d65:	6a 3c                	push   $0x3c
80105d67:	e9 2d f9 ff ff       	jmp    80105699 <alltraps>

80105d6c <vector61>:
80105d6c:	6a 00                	push   $0x0
80105d6e:	6a 3d                	push   $0x3d
80105d70:	e9 24 f9 ff ff       	jmp    80105699 <alltraps>

80105d75 <vector62>:
80105d75:	6a 00                	push   $0x0
80105d77:	6a 3e                	push   $0x3e
80105d79:	e9 1b f9 ff ff       	jmp    80105699 <alltraps>

80105d7e <vector63>:
80105d7e:	6a 00                	push   $0x0
80105d80:	6a 3f                	push   $0x3f
80105d82:	e9 12 f9 ff ff       	jmp    80105699 <alltraps>

80105d87 <vector64>:
80105d87:	6a 00                	push   $0x0
80105d89:	6a 40                	push   $0x40
80105d8b:	e9 09 f9 ff ff       	jmp    80105699 <alltraps>

80105d90 <vector65>:
80105d90:	6a 00                	push   $0x0
80105d92:	6a 41                	push   $0x41
80105d94:	e9 00 f9 ff ff       	jmp    80105699 <alltraps>

80105d99 <vector66>:
80105d99:	6a 00                	push   $0x0
80105d9b:	6a 42                	push   $0x42
80105d9d:	e9 f7 f8 ff ff       	jmp    80105699 <alltraps>

80105da2 <vector67>:
80105da2:	6a 00                	push   $0x0
80105da4:	6a 43                	push   $0x43
80105da6:	e9 ee f8 ff ff       	jmp    80105699 <alltraps>

80105dab <vector68>:
80105dab:	6a 00                	push   $0x0
80105dad:	6a 44                	push   $0x44
80105daf:	e9 e5 f8 ff ff       	jmp    80105699 <alltraps>

80105db4 <vector69>:
80105db4:	6a 00                	push   $0x0
80105db6:	6a 45                	push   $0x45
80105db8:	e9 dc f8 ff ff       	jmp    80105699 <alltraps>

80105dbd <vector70>:
80105dbd:	6a 00                	push   $0x0
80105dbf:	6a 46                	push   $0x46
80105dc1:	e9 d3 f8 ff ff       	jmp    80105699 <alltraps>

80105dc6 <vector71>:
80105dc6:	6a 00                	push   $0x0
80105dc8:	6a 47                	push   $0x47
80105dca:	e9 ca f8 ff ff       	jmp    80105699 <alltraps>

80105dcf <vector72>:
80105dcf:	6a 00                	push   $0x0
80105dd1:	6a 48                	push   $0x48
80105dd3:	e9 c1 f8 ff ff       	jmp    80105699 <alltraps>

80105dd8 <vector73>:
80105dd8:	6a 00                	push   $0x0
80105dda:	6a 49                	push   $0x49
80105ddc:	e9 b8 f8 ff ff       	jmp    80105699 <alltraps>

80105de1 <vector74>:
80105de1:	6a 00                	push   $0x0
80105de3:	6a 4a                	push   $0x4a
80105de5:	e9 af f8 ff ff       	jmp    80105699 <alltraps>

80105dea <vector75>:
80105dea:	6a 00                	push   $0x0
80105dec:	6a 4b                	push   $0x4b
80105dee:	e9 a6 f8 ff ff       	jmp    80105699 <alltraps>

80105df3 <vector76>:
80105df3:	6a 00                	push   $0x0
80105df5:	6a 4c                	push   $0x4c
80105df7:	e9 9d f8 ff ff       	jmp    80105699 <alltraps>

80105dfc <vector77>:
80105dfc:	6a 00                	push   $0x0
80105dfe:	6a 4d                	push   $0x4d
80105e00:	e9 94 f8 ff ff       	jmp    80105699 <alltraps>

80105e05 <vector78>:
80105e05:	6a 00                	push   $0x0
80105e07:	6a 4e                	push   $0x4e
80105e09:	e9 8b f8 ff ff       	jmp    80105699 <alltraps>

80105e0e <vector79>:
80105e0e:	6a 00                	push   $0x0
80105e10:	6a 4f                	push   $0x4f
80105e12:	e9 82 f8 ff ff       	jmp    80105699 <alltraps>

80105e17 <vector80>:
80105e17:	6a 00                	push   $0x0
80105e19:	6a 50                	push   $0x50
80105e1b:	e9 79 f8 ff ff       	jmp    80105699 <alltraps>

80105e20 <vector81>:
80105e20:	6a 00                	push   $0x0
80105e22:	6a 51                	push   $0x51
80105e24:	e9 70 f8 ff ff       	jmp    80105699 <alltraps>

80105e29 <vector82>:
80105e29:	6a 00                	push   $0x0
80105e2b:	6a 52                	push   $0x52
80105e2d:	e9 67 f8 ff ff       	jmp    80105699 <alltraps>

80105e32 <vector83>:
80105e32:	6a 00                	push   $0x0
80105e34:	6a 53                	push   $0x53
80105e36:	e9 5e f8 ff ff       	jmp    80105699 <alltraps>

80105e3b <vector84>:
80105e3b:	6a 00                	push   $0x0
80105e3d:	6a 54                	push   $0x54
80105e3f:	e9 55 f8 ff ff       	jmp    80105699 <alltraps>

80105e44 <vector85>:
80105e44:	6a 00                	push   $0x0
80105e46:	6a 55                	push   $0x55
80105e48:	e9 4c f8 ff ff       	jmp    80105699 <alltraps>

80105e4d <vector86>:
80105e4d:	6a 00                	push   $0x0
80105e4f:	6a 56                	push   $0x56
80105e51:	e9 43 f8 ff ff       	jmp    80105699 <alltraps>

80105e56 <vector87>:
80105e56:	6a 00                	push   $0x0
80105e58:	6a 57                	push   $0x57
80105e5a:	e9 3a f8 ff ff       	jmp    80105699 <alltraps>

80105e5f <vector88>:
80105e5f:	6a 00                	push   $0x0
80105e61:	6a 58                	push   $0x58
80105e63:	e9 31 f8 ff ff       	jmp    80105699 <alltraps>

80105e68 <vector89>:
80105e68:	6a 00                	push   $0x0
80105e6a:	6a 59                	push   $0x59
80105e6c:	e9 28 f8 ff ff       	jmp    80105699 <alltraps>

80105e71 <vector90>:
80105e71:	6a 00                	push   $0x0
80105e73:	6a 5a                	push   $0x5a
80105e75:	e9 1f f8 ff ff       	jmp    80105699 <alltraps>

80105e7a <vector91>:
80105e7a:	6a 00                	push   $0x0
80105e7c:	6a 5b                	push   $0x5b
80105e7e:	e9 16 f8 ff ff       	jmp    80105699 <alltraps>

80105e83 <vector92>:
80105e83:	6a 00                	push   $0x0
80105e85:	6a 5c                	push   $0x5c
80105e87:	e9 0d f8 ff ff       	jmp    80105699 <alltraps>

80105e8c <vector93>:
80105e8c:	6a 00                	push   $0x0
80105e8e:	6a 5d                	push   $0x5d
80105e90:	e9 04 f8 ff ff       	jmp    80105699 <alltraps>

80105e95 <vector94>:
80105e95:	6a 00                	push   $0x0
80105e97:	6a 5e                	push   $0x5e
80105e99:	e9 fb f7 ff ff       	jmp    80105699 <alltraps>

80105e9e <vector95>:
80105e9e:	6a 00                	push   $0x0
80105ea0:	6a 5f                	push   $0x5f
80105ea2:	e9 f2 f7 ff ff       	jmp    80105699 <alltraps>

80105ea7 <vector96>:
80105ea7:	6a 00                	push   $0x0
80105ea9:	6a 60                	push   $0x60
80105eab:	e9 e9 f7 ff ff       	jmp    80105699 <alltraps>

80105eb0 <vector97>:
80105eb0:	6a 00                	push   $0x0
80105eb2:	6a 61                	push   $0x61
80105eb4:	e9 e0 f7 ff ff       	jmp    80105699 <alltraps>

80105eb9 <vector98>:
80105eb9:	6a 00                	push   $0x0
80105ebb:	6a 62                	push   $0x62
80105ebd:	e9 d7 f7 ff ff       	jmp    80105699 <alltraps>

80105ec2 <vector99>:
80105ec2:	6a 00                	push   $0x0
80105ec4:	6a 63                	push   $0x63
80105ec6:	e9 ce f7 ff ff       	jmp    80105699 <alltraps>

80105ecb <vector100>:
80105ecb:	6a 00                	push   $0x0
80105ecd:	6a 64                	push   $0x64
80105ecf:	e9 c5 f7 ff ff       	jmp    80105699 <alltraps>

80105ed4 <vector101>:
80105ed4:	6a 00                	push   $0x0
80105ed6:	6a 65                	push   $0x65
80105ed8:	e9 bc f7 ff ff       	jmp    80105699 <alltraps>

80105edd <vector102>:
80105edd:	6a 00                	push   $0x0
80105edf:	6a 66                	push   $0x66
80105ee1:	e9 b3 f7 ff ff       	jmp    80105699 <alltraps>

80105ee6 <vector103>:
80105ee6:	6a 00                	push   $0x0
80105ee8:	6a 67                	push   $0x67
80105eea:	e9 aa f7 ff ff       	jmp    80105699 <alltraps>

80105eef <vector104>:
80105eef:	6a 00                	push   $0x0
80105ef1:	6a 68                	push   $0x68
80105ef3:	e9 a1 f7 ff ff       	jmp    80105699 <alltraps>

80105ef8 <vector105>:
80105ef8:	6a 00                	push   $0x0
80105efa:	6a 69                	push   $0x69
80105efc:	e9 98 f7 ff ff       	jmp    80105699 <alltraps>

80105f01 <vector106>:
80105f01:	6a 00                	push   $0x0
80105f03:	6a 6a                	push   $0x6a
80105f05:	e9 8f f7 ff ff       	jmp    80105699 <alltraps>

80105f0a <vector107>:
80105f0a:	6a 00                	push   $0x0
80105f0c:	6a 6b                	push   $0x6b
80105f0e:	e9 86 f7 ff ff       	jmp    80105699 <alltraps>

80105f13 <vector108>:
80105f13:	6a 00                	push   $0x0
80105f15:	6a 6c                	push   $0x6c
80105f17:	e9 7d f7 ff ff       	jmp    80105699 <alltraps>

80105f1c <vector109>:
80105f1c:	6a 00                	push   $0x0
80105f1e:	6a 6d                	push   $0x6d
80105f20:	e9 74 f7 ff ff       	jmp    80105699 <alltraps>

80105f25 <vector110>:
80105f25:	6a 00                	push   $0x0
80105f27:	6a 6e                	push   $0x6e
80105f29:	e9 6b f7 ff ff       	jmp    80105699 <alltraps>

80105f2e <vector111>:
80105f2e:	6a 00                	push   $0x0
80105f30:	6a 6f                	push   $0x6f
80105f32:	e9 62 f7 ff ff       	jmp    80105699 <alltraps>

80105f37 <vector112>:
80105f37:	6a 00                	push   $0x0
80105f39:	6a 70                	push   $0x70
80105f3b:	e9 59 f7 ff ff       	jmp    80105699 <alltraps>

80105f40 <vector113>:
80105f40:	6a 00                	push   $0x0
80105f42:	6a 71                	push   $0x71
80105f44:	e9 50 f7 ff ff       	jmp    80105699 <alltraps>

80105f49 <vector114>:
80105f49:	6a 00                	push   $0x0
80105f4b:	6a 72                	push   $0x72
80105f4d:	e9 47 f7 ff ff       	jmp    80105699 <alltraps>

80105f52 <vector115>:
80105f52:	6a 00                	push   $0x0
80105f54:	6a 73                	push   $0x73
80105f56:	e9 3e f7 ff ff       	jmp    80105699 <alltraps>

80105f5b <vector116>:
80105f5b:	6a 00                	push   $0x0
80105f5d:	6a 74                	push   $0x74
80105f5f:	e9 35 f7 ff ff       	jmp    80105699 <alltraps>

80105f64 <vector117>:
80105f64:	6a 00                	push   $0x0
80105f66:	6a 75                	push   $0x75
80105f68:	e9 2c f7 ff ff       	jmp    80105699 <alltraps>

80105f6d <vector118>:
80105f6d:	6a 00                	push   $0x0
80105f6f:	6a 76                	push   $0x76
80105f71:	e9 23 f7 ff ff       	jmp    80105699 <alltraps>

80105f76 <vector119>:
80105f76:	6a 00                	push   $0x0
80105f78:	6a 77                	push   $0x77
80105f7a:	e9 1a f7 ff ff       	jmp    80105699 <alltraps>

80105f7f <vector120>:
80105f7f:	6a 00                	push   $0x0
80105f81:	6a 78                	push   $0x78
80105f83:	e9 11 f7 ff ff       	jmp    80105699 <alltraps>

80105f88 <vector121>:
80105f88:	6a 00                	push   $0x0
80105f8a:	6a 79                	push   $0x79
80105f8c:	e9 08 f7 ff ff       	jmp    80105699 <alltraps>

80105f91 <vector122>:
80105f91:	6a 00                	push   $0x0
80105f93:	6a 7a                	push   $0x7a
80105f95:	e9 ff f6 ff ff       	jmp    80105699 <alltraps>

80105f9a <vector123>:
80105f9a:	6a 00                	push   $0x0
80105f9c:	6a 7b                	push   $0x7b
80105f9e:	e9 f6 f6 ff ff       	jmp    80105699 <alltraps>

80105fa3 <vector124>:
80105fa3:	6a 00                	push   $0x0
80105fa5:	6a 7c                	push   $0x7c
80105fa7:	e9 ed f6 ff ff       	jmp    80105699 <alltraps>

80105fac <vector125>:
80105fac:	6a 00                	push   $0x0
80105fae:	6a 7d                	push   $0x7d
80105fb0:	e9 e4 f6 ff ff       	jmp    80105699 <alltraps>

80105fb5 <vector126>:
80105fb5:	6a 00                	push   $0x0
80105fb7:	6a 7e                	push   $0x7e
80105fb9:	e9 db f6 ff ff       	jmp    80105699 <alltraps>

80105fbe <vector127>:
80105fbe:	6a 00                	push   $0x0
80105fc0:	6a 7f                	push   $0x7f
80105fc2:	e9 d2 f6 ff ff       	jmp    80105699 <alltraps>

80105fc7 <vector128>:
80105fc7:	6a 00                	push   $0x0
80105fc9:	68 80 00 00 00       	push   $0x80
80105fce:	e9 c6 f6 ff ff       	jmp    80105699 <alltraps>

80105fd3 <vector129>:
80105fd3:	6a 00                	push   $0x0
80105fd5:	68 81 00 00 00       	push   $0x81
80105fda:	e9 ba f6 ff ff       	jmp    80105699 <alltraps>

80105fdf <vector130>:
80105fdf:	6a 00                	push   $0x0
80105fe1:	68 82 00 00 00       	push   $0x82
80105fe6:	e9 ae f6 ff ff       	jmp    80105699 <alltraps>

80105feb <vector131>:
80105feb:	6a 00                	push   $0x0
80105fed:	68 83 00 00 00       	push   $0x83
80105ff2:	e9 a2 f6 ff ff       	jmp    80105699 <alltraps>

80105ff7 <vector132>:
80105ff7:	6a 00                	push   $0x0
80105ff9:	68 84 00 00 00       	push   $0x84
80105ffe:	e9 96 f6 ff ff       	jmp    80105699 <alltraps>

80106003 <vector133>:
80106003:	6a 00                	push   $0x0
80106005:	68 85 00 00 00       	push   $0x85
8010600a:	e9 8a f6 ff ff       	jmp    80105699 <alltraps>

8010600f <vector134>:
8010600f:	6a 00                	push   $0x0
80106011:	68 86 00 00 00       	push   $0x86
80106016:	e9 7e f6 ff ff       	jmp    80105699 <alltraps>

8010601b <vector135>:
8010601b:	6a 00                	push   $0x0
8010601d:	68 87 00 00 00       	push   $0x87
80106022:	e9 72 f6 ff ff       	jmp    80105699 <alltraps>

80106027 <vector136>:
80106027:	6a 00                	push   $0x0
80106029:	68 88 00 00 00       	push   $0x88
8010602e:	e9 66 f6 ff ff       	jmp    80105699 <alltraps>

80106033 <vector137>:
80106033:	6a 00                	push   $0x0
80106035:	68 89 00 00 00       	push   $0x89
8010603a:	e9 5a f6 ff ff       	jmp    80105699 <alltraps>

8010603f <vector138>:
8010603f:	6a 00                	push   $0x0
80106041:	68 8a 00 00 00       	push   $0x8a
80106046:	e9 4e f6 ff ff       	jmp    80105699 <alltraps>

8010604b <vector139>:
8010604b:	6a 00                	push   $0x0
8010604d:	68 8b 00 00 00       	push   $0x8b
80106052:	e9 42 f6 ff ff       	jmp    80105699 <alltraps>

80106057 <vector140>:
80106057:	6a 00                	push   $0x0
80106059:	68 8c 00 00 00       	push   $0x8c
8010605e:	e9 36 f6 ff ff       	jmp    80105699 <alltraps>

80106063 <vector141>:
80106063:	6a 00                	push   $0x0
80106065:	68 8d 00 00 00       	push   $0x8d
8010606a:	e9 2a f6 ff ff       	jmp    80105699 <alltraps>

8010606f <vector142>:
8010606f:	6a 00                	push   $0x0
80106071:	68 8e 00 00 00       	push   $0x8e
80106076:	e9 1e f6 ff ff       	jmp    80105699 <alltraps>

8010607b <vector143>:
8010607b:	6a 00                	push   $0x0
8010607d:	68 8f 00 00 00       	push   $0x8f
80106082:	e9 12 f6 ff ff       	jmp    80105699 <alltraps>

80106087 <vector144>:
80106087:	6a 00                	push   $0x0
80106089:	68 90 00 00 00       	push   $0x90
8010608e:	e9 06 f6 ff ff       	jmp    80105699 <alltraps>

80106093 <vector145>:
80106093:	6a 00                	push   $0x0
80106095:	68 91 00 00 00       	push   $0x91
8010609a:	e9 fa f5 ff ff       	jmp    80105699 <alltraps>

8010609f <vector146>:
8010609f:	6a 00                	push   $0x0
801060a1:	68 92 00 00 00       	push   $0x92
801060a6:	e9 ee f5 ff ff       	jmp    80105699 <alltraps>

801060ab <vector147>:
801060ab:	6a 00                	push   $0x0
801060ad:	68 93 00 00 00       	push   $0x93
801060b2:	e9 e2 f5 ff ff       	jmp    80105699 <alltraps>

801060b7 <vector148>:
801060b7:	6a 00                	push   $0x0
801060b9:	68 94 00 00 00       	push   $0x94
801060be:	e9 d6 f5 ff ff       	jmp    80105699 <alltraps>

801060c3 <vector149>:
801060c3:	6a 00                	push   $0x0
801060c5:	68 95 00 00 00       	push   $0x95
801060ca:	e9 ca f5 ff ff       	jmp    80105699 <alltraps>

801060cf <vector150>:
801060cf:	6a 00                	push   $0x0
801060d1:	68 96 00 00 00       	push   $0x96
801060d6:	e9 be f5 ff ff       	jmp    80105699 <alltraps>

801060db <vector151>:
801060db:	6a 00                	push   $0x0
801060dd:	68 97 00 00 00       	push   $0x97
801060e2:	e9 b2 f5 ff ff       	jmp    80105699 <alltraps>

801060e7 <vector152>:
801060e7:	6a 00                	push   $0x0
801060e9:	68 98 00 00 00       	push   $0x98
801060ee:	e9 a6 f5 ff ff       	jmp    80105699 <alltraps>

801060f3 <vector153>:
801060f3:	6a 00                	push   $0x0
801060f5:	68 99 00 00 00       	push   $0x99
801060fa:	e9 9a f5 ff ff       	jmp    80105699 <alltraps>

801060ff <vector154>:
801060ff:	6a 00                	push   $0x0
80106101:	68 9a 00 00 00       	push   $0x9a
80106106:	e9 8e f5 ff ff       	jmp    80105699 <alltraps>

8010610b <vector155>:
8010610b:	6a 00                	push   $0x0
8010610d:	68 9b 00 00 00       	push   $0x9b
80106112:	e9 82 f5 ff ff       	jmp    80105699 <alltraps>

80106117 <vector156>:
80106117:	6a 00                	push   $0x0
80106119:	68 9c 00 00 00       	push   $0x9c
8010611e:	e9 76 f5 ff ff       	jmp    80105699 <alltraps>

80106123 <vector157>:
80106123:	6a 00                	push   $0x0
80106125:	68 9d 00 00 00       	push   $0x9d
8010612a:	e9 6a f5 ff ff       	jmp    80105699 <alltraps>

8010612f <vector158>:
8010612f:	6a 00                	push   $0x0
80106131:	68 9e 00 00 00       	push   $0x9e
80106136:	e9 5e f5 ff ff       	jmp    80105699 <alltraps>

8010613b <vector159>:
8010613b:	6a 00                	push   $0x0
8010613d:	68 9f 00 00 00       	push   $0x9f
80106142:	e9 52 f5 ff ff       	jmp    80105699 <alltraps>

80106147 <vector160>:
80106147:	6a 00                	push   $0x0
80106149:	68 a0 00 00 00       	push   $0xa0
8010614e:	e9 46 f5 ff ff       	jmp    80105699 <alltraps>

80106153 <vector161>:
80106153:	6a 00                	push   $0x0
80106155:	68 a1 00 00 00       	push   $0xa1
8010615a:	e9 3a f5 ff ff       	jmp    80105699 <alltraps>

8010615f <vector162>:
8010615f:	6a 00                	push   $0x0
80106161:	68 a2 00 00 00       	push   $0xa2
80106166:	e9 2e f5 ff ff       	jmp    80105699 <alltraps>

8010616b <vector163>:
8010616b:	6a 00                	push   $0x0
8010616d:	68 a3 00 00 00       	push   $0xa3
80106172:	e9 22 f5 ff ff       	jmp    80105699 <alltraps>

80106177 <vector164>:
80106177:	6a 00                	push   $0x0
80106179:	68 a4 00 00 00       	push   $0xa4
8010617e:	e9 16 f5 ff ff       	jmp    80105699 <alltraps>

80106183 <vector165>:
80106183:	6a 00                	push   $0x0
80106185:	68 a5 00 00 00       	push   $0xa5
8010618a:	e9 0a f5 ff ff       	jmp    80105699 <alltraps>

8010618f <vector166>:
8010618f:	6a 00                	push   $0x0
80106191:	68 a6 00 00 00       	push   $0xa6
80106196:	e9 fe f4 ff ff       	jmp    80105699 <alltraps>

8010619b <vector167>:
8010619b:	6a 00                	push   $0x0
8010619d:	68 a7 00 00 00       	push   $0xa7
801061a2:	e9 f2 f4 ff ff       	jmp    80105699 <alltraps>

801061a7 <vector168>:
801061a7:	6a 00                	push   $0x0
801061a9:	68 a8 00 00 00       	push   $0xa8
801061ae:	e9 e6 f4 ff ff       	jmp    80105699 <alltraps>

801061b3 <vector169>:
801061b3:	6a 00                	push   $0x0
801061b5:	68 a9 00 00 00       	push   $0xa9
801061ba:	e9 da f4 ff ff       	jmp    80105699 <alltraps>

801061bf <vector170>:
801061bf:	6a 00                	push   $0x0
801061c1:	68 aa 00 00 00       	push   $0xaa
801061c6:	e9 ce f4 ff ff       	jmp    80105699 <alltraps>

801061cb <vector171>:
801061cb:	6a 00                	push   $0x0
801061cd:	68 ab 00 00 00       	push   $0xab
801061d2:	e9 c2 f4 ff ff       	jmp    80105699 <alltraps>

801061d7 <vector172>:
801061d7:	6a 00                	push   $0x0
801061d9:	68 ac 00 00 00       	push   $0xac
801061de:	e9 b6 f4 ff ff       	jmp    80105699 <alltraps>

801061e3 <vector173>:
801061e3:	6a 00                	push   $0x0
801061e5:	68 ad 00 00 00       	push   $0xad
801061ea:	e9 aa f4 ff ff       	jmp    80105699 <alltraps>

801061ef <vector174>:
801061ef:	6a 00                	push   $0x0
801061f1:	68 ae 00 00 00       	push   $0xae
801061f6:	e9 9e f4 ff ff       	jmp    80105699 <alltraps>

801061fb <vector175>:
801061fb:	6a 00                	push   $0x0
801061fd:	68 af 00 00 00       	push   $0xaf
80106202:	e9 92 f4 ff ff       	jmp    80105699 <alltraps>

80106207 <vector176>:
80106207:	6a 00                	push   $0x0
80106209:	68 b0 00 00 00       	push   $0xb0
8010620e:	e9 86 f4 ff ff       	jmp    80105699 <alltraps>

80106213 <vector177>:
80106213:	6a 00                	push   $0x0
80106215:	68 b1 00 00 00       	push   $0xb1
8010621a:	e9 7a f4 ff ff       	jmp    80105699 <alltraps>

8010621f <vector178>:
8010621f:	6a 00                	push   $0x0
80106221:	68 b2 00 00 00       	push   $0xb2
80106226:	e9 6e f4 ff ff       	jmp    80105699 <alltraps>

8010622b <vector179>:
8010622b:	6a 00                	push   $0x0
8010622d:	68 b3 00 00 00       	push   $0xb3
80106232:	e9 62 f4 ff ff       	jmp    80105699 <alltraps>

80106237 <vector180>:
80106237:	6a 00                	push   $0x0
80106239:	68 b4 00 00 00       	push   $0xb4
8010623e:	e9 56 f4 ff ff       	jmp    80105699 <alltraps>

80106243 <vector181>:
80106243:	6a 00                	push   $0x0
80106245:	68 b5 00 00 00       	push   $0xb5
8010624a:	e9 4a f4 ff ff       	jmp    80105699 <alltraps>

8010624f <vector182>:
8010624f:	6a 00                	push   $0x0
80106251:	68 b6 00 00 00       	push   $0xb6
80106256:	e9 3e f4 ff ff       	jmp    80105699 <alltraps>

8010625b <vector183>:
8010625b:	6a 00                	push   $0x0
8010625d:	68 b7 00 00 00       	push   $0xb7
80106262:	e9 32 f4 ff ff       	jmp    80105699 <alltraps>

80106267 <vector184>:
80106267:	6a 00                	push   $0x0
80106269:	68 b8 00 00 00       	push   $0xb8
8010626e:	e9 26 f4 ff ff       	jmp    80105699 <alltraps>

80106273 <vector185>:
80106273:	6a 00                	push   $0x0
80106275:	68 b9 00 00 00       	push   $0xb9
8010627a:	e9 1a f4 ff ff       	jmp    80105699 <alltraps>

8010627f <vector186>:
8010627f:	6a 00                	push   $0x0
80106281:	68 ba 00 00 00       	push   $0xba
80106286:	e9 0e f4 ff ff       	jmp    80105699 <alltraps>

8010628b <vector187>:
8010628b:	6a 00                	push   $0x0
8010628d:	68 bb 00 00 00       	push   $0xbb
80106292:	e9 02 f4 ff ff       	jmp    80105699 <alltraps>

80106297 <vector188>:
80106297:	6a 00                	push   $0x0
80106299:	68 bc 00 00 00       	push   $0xbc
8010629e:	e9 f6 f3 ff ff       	jmp    80105699 <alltraps>

801062a3 <vector189>:
801062a3:	6a 00                	push   $0x0
801062a5:	68 bd 00 00 00       	push   $0xbd
801062aa:	e9 ea f3 ff ff       	jmp    80105699 <alltraps>

801062af <vector190>:
801062af:	6a 00                	push   $0x0
801062b1:	68 be 00 00 00       	push   $0xbe
801062b6:	e9 de f3 ff ff       	jmp    80105699 <alltraps>

801062bb <vector191>:
801062bb:	6a 00                	push   $0x0
801062bd:	68 bf 00 00 00       	push   $0xbf
801062c2:	e9 d2 f3 ff ff       	jmp    80105699 <alltraps>

801062c7 <vector192>:
801062c7:	6a 00                	push   $0x0
801062c9:	68 c0 00 00 00       	push   $0xc0
801062ce:	e9 c6 f3 ff ff       	jmp    80105699 <alltraps>

801062d3 <vector193>:
801062d3:	6a 00                	push   $0x0
801062d5:	68 c1 00 00 00       	push   $0xc1
801062da:	e9 ba f3 ff ff       	jmp    80105699 <alltraps>

801062df <vector194>:
801062df:	6a 00                	push   $0x0
801062e1:	68 c2 00 00 00       	push   $0xc2
801062e6:	e9 ae f3 ff ff       	jmp    80105699 <alltraps>

801062eb <vector195>:
801062eb:	6a 00                	push   $0x0
801062ed:	68 c3 00 00 00       	push   $0xc3
801062f2:	e9 a2 f3 ff ff       	jmp    80105699 <alltraps>

801062f7 <vector196>:
801062f7:	6a 00                	push   $0x0
801062f9:	68 c4 00 00 00       	push   $0xc4
801062fe:	e9 96 f3 ff ff       	jmp    80105699 <alltraps>

80106303 <vector197>:
80106303:	6a 00                	push   $0x0
80106305:	68 c5 00 00 00       	push   $0xc5
8010630a:	e9 8a f3 ff ff       	jmp    80105699 <alltraps>

8010630f <vector198>:
8010630f:	6a 00                	push   $0x0
80106311:	68 c6 00 00 00       	push   $0xc6
80106316:	e9 7e f3 ff ff       	jmp    80105699 <alltraps>

8010631b <vector199>:
8010631b:	6a 00                	push   $0x0
8010631d:	68 c7 00 00 00       	push   $0xc7
80106322:	e9 72 f3 ff ff       	jmp    80105699 <alltraps>

80106327 <vector200>:
80106327:	6a 00                	push   $0x0
80106329:	68 c8 00 00 00       	push   $0xc8
8010632e:	e9 66 f3 ff ff       	jmp    80105699 <alltraps>

80106333 <vector201>:
80106333:	6a 00                	push   $0x0
80106335:	68 c9 00 00 00       	push   $0xc9
8010633a:	e9 5a f3 ff ff       	jmp    80105699 <alltraps>

8010633f <vector202>:
8010633f:	6a 00                	push   $0x0
80106341:	68 ca 00 00 00       	push   $0xca
80106346:	e9 4e f3 ff ff       	jmp    80105699 <alltraps>

8010634b <vector203>:
8010634b:	6a 00                	push   $0x0
8010634d:	68 cb 00 00 00       	push   $0xcb
80106352:	e9 42 f3 ff ff       	jmp    80105699 <alltraps>

80106357 <vector204>:
80106357:	6a 00                	push   $0x0
80106359:	68 cc 00 00 00       	push   $0xcc
8010635e:	e9 36 f3 ff ff       	jmp    80105699 <alltraps>

80106363 <vector205>:
80106363:	6a 00                	push   $0x0
80106365:	68 cd 00 00 00       	push   $0xcd
8010636a:	e9 2a f3 ff ff       	jmp    80105699 <alltraps>

8010636f <vector206>:
8010636f:	6a 00                	push   $0x0
80106371:	68 ce 00 00 00       	push   $0xce
80106376:	e9 1e f3 ff ff       	jmp    80105699 <alltraps>

8010637b <vector207>:
8010637b:	6a 00                	push   $0x0
8010637d:	68 cf 00 00 00       	push   $0xcf
80106382:	e9 12 f3 ff ff       	jmp    80105699 <alltraps>

80106387 <vector208>:
80106387:	6a 00                	push   $0x0
80106389:	68 d0 00 00 00       	push   $0xd0
8010638e:	e9 06 f3 ff ff       	jmp    80105699 <alltraps>

80106393 <vector209>:
80106393:	6a 00                	push   $0x0
80106395:	68 d1 00 00 00       	push   $0xd1
8010639a:	e9 fa f2 ff ff       	jmp    80105699 <alltraps>

8010639f <vector210>:
8010639f:	6a 00                	push   $0x0
801063a1:	68 d2 00 00 00       	push   $0xd2
801063a6:	e9 ee f2 ff ff       	jmp    80105699 <alltraps>

801063ab <vector211>:
801063ab:	6a 00                	push   $0x0
801063ad:	68 d3 00 00 00       	push   $0xd3
801063b2:	e9 e2 f2 ff ff       	jmp    80105699 <alltraps>

801063b7 <vector212>:
801063b7:	6a 00                	push   $0x0
801063b9:	68 d4 00 00 00       	push   $0xd4
801063be:	e9 d6 f2 ff ff       	jmp    80105699 <alltraps>

801063c3 <vector213>:
801063c3:	6a 00                	push   $0x0
801063c5:	68 d5 00 00 00       	push   $0xd5
801063ca:	e9 ca f2 ff ff       	jmp    80105699 <alltraps>

801063cf <vector214>:
801063cf:	6a 00                	push   $0x0
801063d1:	68 d6 00 00 00       	push   $0xd6
801063d6:	e9 be f2 ff ff       	jmp    80105699 <alltraps>

801063db <vector215>:
801063db:	6a 00                	push   $0x0
801063dd:	68 d7 00 00 00       	push   $0xd7
801063e2:	e9 b2 f2 ff ff       	jmp    80105699 <alltraps>

801063e7 <vector216>:
801063e7:	6a 00                	push   $0x0
801063e9:	68 d8 00 00 00       	push   $0xd8
801063ee:	e9 a6 f2 ff ff       	jmp    80105699 <alltraps>

801063f3 <vector217>:
801063f3:	6a 00                	push   $0x0
801063f5:	68 d9 00 00 00       	push   $0xd9
801063fa:	e9 9a f2 ff ff       	jmp    80105699 <alltraps>

801063ff <vector218>:
801063ff:	6a 00                	push   $0x0
80106401:	68 da 00 00 00       	push   $0xda
80106406:	e9 8e f2 ff ff       	jmp    80105699 <alltraps>

8010640b <vector219>:
8010640b:	6a 00                	push   $0x0
8010640d:	68 db 00 00 00       	push   $0xdb
80106412:	e9 82 f2 ff ff       	jmp    80105699 <alltraps>

80106417 <vector220>:
80106417:	6a 00                	push   $0x0
80106419:	68 dc 00 00 00       	push   $0xdc
8010641e:	e9 76 f2 ff ff       	jmp    80105699 <alltraps>

80106423 <vector221>:
80106423:	6a 00                	push   $0x0
80106425:	68 dd 00 00 00       	push   $0xdd
8010642a:	e9 6a f2 ff ff       	jmp    80105699 <alltraps>

8010642f <vector222>:
8010642f:	6a 00                	push   $0x0
80106431:	68 de 00 00 00       	push   $0xde
80106436:	e9 5e f2 ff ff       	jmp    80105699 <alltraps>

8010643b <vector223>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 df 00 00 00       	push   $0xdf
80106442:	e9 52 f2 ff ff       	jmp    80105699 <alltraps>

80106447 <vector224>:
80106447:	6a 00                	push   $0x0
80106449:	68 e0 00 00 00       	push   $0xe0
8010644e:	e9 46 f2 ff ff       	jmp    80105699 <alltraps>

80106453 <vector225>:
80106453:	6a 00                	push   $0x0
80106455:	68 e1 00 00 00       	push   $0xe1
8010645a:	e9 3a f2 ff ff       	jmp    80105699 <alltraps>

8010645f <vector226>:
8010645f:	6a 00                	push   $0x0
80106461:	68 e2 00 00 00       	push   $0xe2
80106466:	e9 2e f2 ff ff       	jmp    80105699 <alltraps>

8010646b <vector227>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 e3 00 00 00       	push   $0xe3
80106472:	e9 22 f2 ff ff       	jmp    80105699 <alltraps>

80106477 <vector228>:
80106477:	6a 00                	push   $0x0
80106479:	68 e4 00 00 00       	push   $0xe4
8010647e:	e9 16 f2 ff ff       	jmp    80105699 <alltraps>

80106483 <vector229>:
80106483:	6a 00                	push   $0x0
80106485:	68 e5 00 00 00       	push   $0xe5
8010648a:	e9 0a f2 ff ff       	jmp    80105699 <alltraps>

8010648f <vector230>:
8010648f:	6a 00                	push   $0x0
80106491:	68 e6 00 00 00       	push   $0xe6
80106496:	e9 fe f1 ff ff       	jmp    80105699 <alltraps>

8010649b <vector231>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 e7 00 00 00       	push   $0xe7
801064a2:	e9 f2 f1 ff ff       	jmp    80105699 <alltraps>

801064a7 <vector232>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 e8 00 00 00       	push   $0xe8
801064ae:	e9 e6 f1 ff ff       	jmp    80105699 <alltraps>

801064b3 <vector233>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 e9 00 00 00       	push   $0xe9
801064ba:	e9 da f1 ff ff       	jmp    80105699 <alltraps>

801064bf <vector234>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 ea 00 00 00       	push   $0xea
801064c6:	e9 ce f1 ff ff       	jmp    80105699 <alltraps>

801064cb <vector235>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 eb 00 00 00       	push   $0xeb
801064d2:	e9 c2 f1 ff ff       	jmp    80105699 <alltraps>

801064d7 <vector236>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 ec 00 00 00       	push   $0xec
801064de:	e9 b6 f1 ff ff       	jmp    80105699 <alltraps>

801064e3 <vector237>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 ed 00 00 00       	push   $0xed
801064ea:	e9 aa f1 ff ff       	jmp    80105699 <alltraps>

801064ef <vector238>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 ee 00 00 00       	push   $0xee
801064f6:	e9 9e f1 ff ff       	jmp    80105699 <alltraps>

801064fb <vector239>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 ef 00 00 00       	push   $0xef
80106502:	e9 92 f1 ff ff       	jmp    80105699 <alltraps>

80106507 <vector240>:
80106507:	6a 00                	push   $0x0
80106509:	68 f0 00 00 00       	push   $0xf0
8010650e:	e9 86 f1 ff ff       	jmp    80105699 <alltraps>

80106513 <vector241>:
80106513:	6a 00                	push   $0x0
80106515:	68 f1 00 00 00       	push   $0xf1
8010651a:	e9 7a f1 ff ff       	jmp    80105699 <alltraps>

8010651f <vector242>:
8010651f:	6a 00                	push   $0x0
80106521:	68 f2 00 00 00       	push   $0xf2
80106526:	e9 6e f1 ff ff       	jmp    80105699 <alltraps>

8010652b <vector243>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 f3 00 00 00       	push   $0xf3
80106532:	e9 62 f1 ff ff       	jmp    80105699 <alltraps>

80106537 <vector244>:
80106537:	6a 00                	push   $0x0
80106539:	68 f4 00 00 00       	push   $0xf4
8010653e:	e9 56 f1 ff ff       	jmp    80105699 <alltraps>

80106543 <vector245>:
80106543:	6a 00                	push   $0x0
80106545:	68 f5 00 00 00       	push   $0xf5
8010654a:	e9 4a f1 ff ff       	jmp    80105699 <alltraps>

8010654f <vector246>:
8010654f:	6a 00                	push   $0x0
80106551:	68 f6 00 00 00       	push   $0xf6
80106556:	e9 3e f1 ff ff       	jmp    80105699 <alltraps>

8010655b <vector247>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 f7 00 00 00       	push   $0xf7
80106562:	e9 32 f1 ff ff       	jmp    80105699 <alltraps>

80106567 <vector248>:
80106567:	6a 00                	push   $0x0
80106569:	68 f8 00 00 00       	push   $0xf8
8010656e:	e9 26 f1 ff ff       	jmp    80105699 <alltraps>

80106573 <vector249>:
80106573:	6a 00                	push   $0x0
80106575:	68 f9 00 00 00       	push   $0xf9
8010657a:	e9 1a f1 ff ff       	jmp    80105699 <alltraps>

8010657f <vector250>:
8010657f:	6a 00                	push   $0x0
80106581:	68 fa 00 00 00       	push   $0xfa
80106586:	e9 0e f1 ff ff       	jmp    80105699 <alltraps>

8010658b <vector251>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 fb 00 00 00       	push   $0xfb
80106592:	e9 02 f1 ff ff       	jmp    80105699 <alltraps>

80106597 <vector252>:
80106597:	6a 00                	push   $0x0
80106599:	68 fc 00 00 00       	push   $0xfc
8010659e:	e9 f6 f0 ff ff       	jmp    80105699 <alltraps>

801065a3 <vector253>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 fd 00 00 00       	push   $0xfd
801065aa:	e9 ea f0 ff ff       	jmp    80105699 <alltraps>

801065af <vector254>:
801065af:	6a 00                	push   $0x0
801065b1:	68 fe 00 00 00       	push   $0xfe
801065b6:	e9 de f0 ff ff       	jmp    80105699 <alltraps>

801065bb <vector255>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 ff 00 00 00       	push   $0xff
801065c2:	e9 d2 f0 ff ff       	jmp    80105699 <alltraps>
801065c7:	66 90                	xchg   %ax,%ax
801065c9:	66 90                	xchg   %ax,%ax
801065cb:	66 90                	xchg   %ax,%ax
801065cd:	66 90                	xchg   %ax,%ax
801065cf:	90                   	nop

801065d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
801065d3:	57                   	push   %edi
801065d4:	56                   	push   %esi
801065d5:	53                   	push   %ebx
801065d6:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801065d8:	c1 ea 16             	shr    $0x16,%edx
801065db:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801065de:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801065e1:	8b 07                	mov    (%edi),%eax
801065e3:	a8 01                	test   $0x1,%al
801065e5:	74 29                	je     80106610 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801065e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801065ec:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801065f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801065f5:	c1 eb 0a             	shr    $0xa,%ebx
801065f8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801065fe:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106601:	5b                   	pop    %ebx
80106602:	5e                   	pop    %esi
80106603:	5f                   	pop    %edi
80106604:	5d                   	pop    %ebp
80106605:	c3                   	ret    
80106606:	8d 76 00             	lea    0x0(%esi),%esi
80106609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106610:	85 c9                	test   %ecx,%ecx
80106612:	74 2c                	je     80106640 <walkpgdir+0x70>
80106614:	e8 67 be ff ff       	call   80102480 <kalloc>
80106619:	85 c0                	test   %eax,%eax
8010661b:	89 c6                	mov    %eax,%esi
8010661d:	74 21                	je     80106640 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010661f:	83 ec 04             	sub    $0x4,%esp
80106622:	68 00 10 00 00       	push   $0x1000
80106627:	6a 00                	push   $0x0
80106629:	50                   	push   %eax
8010662a:	e8 61 de ff ff       	call   80104490 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010662f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106635:	83 c4 10             	add    $0x10,%esp
80106638:	83 c8 07             	or     $0x7,%eax
8010663b:	89 07                	mov    %eax,(%edi)
8010663d:	eb b3                	jmp    801065f2 <walkpgdir+0x22>
8010663f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106640:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106643:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106645:	5b                   	pop    %ebx
80106646:	5e                   	pop    %esi
80106647:	5f                   	pop    %edi
80106648:	5d                   	pop    %ebp
80106649:	c3                   	ret    
8010664a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106650 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	57                   	push   %edi
80106654:	56                   	push   %esi
80106655:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106656:	89 d3                	mov    %edx,%ebx
80106658:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010665e:	83 ec 1c             	sub    $0x1c,%esp
80106661:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106664:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106668:	8b 7d 08             	mov    0x8(%ebp),%edi
8010666b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106673:	8b 45 0c             	mov    0xc(%ebp),%eax
80106676:	29 df                	sub    %ebx,%edi
80106678:	83 c8 01             	or     $0x1,%eax
8010667b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010667e:	eb 15                	jmp    80106695 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106680:	f6 00 01             	testb  $0x1,(%eax)
80106683:	75 45                	jne    801066ca <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106685:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106688:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010668b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010668d:	74 31                	je     801066c0 <mappages+0x70>
      break;
    a += PGSIZE;
8010668f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106695:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106698:	b9 01 00 00 00       	mov    $0x1,%ecx
8010669d:	89 da                	mov    %ebx,%edx
8010669f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801066a2:	e8 29 ff ff ff       	call   801065d0 <walkpgdir>
801066a7:	85 c0                	test   %eax,%eax
801066a9:	75 d5                	jne    80106680 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801066ab:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801066ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801066b3:	5b                   	pop    %ebx
801066b4:	5e                   	pop    %esi
801066b5:	5f                   	pop    %edi
801066b6:	5d                   	pop    %ebp
801066b7:	c3                   	ret    
801066b8:	90                   	nop
801066b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801066c3:	31 c0                	xor    %eax,%eax
}
801066c5:	5b                   	pop    %ebx
801066c6:	5e                   	pop    %esi
801066c7:	5f                   	pop    %edi
801066c8:	5d                   	pop    %ebp
801066c9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801066ca:	83 ec 0c             	sub    $0xc,%esp
801066cd:	68 2c 78 10 80       	push   $0x8010782c
801066d2:	e8 99 9c ff ff       	call   80100370 <panic>
801066d7:	89 f6                	mov    %esi,%esi
801066d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066e0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066e0:	55                   	push   %ebp
801066e1:	89 e5                	mov    %esp,%ebp
801066e3:	57                   	push   %edi
801066e4:	56                   	push   %esi
801066e5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801066e6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066ec:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801066ee:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066f4:	83 ec 1c             	sub    $0x1c,%esp
801066f7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801066fa:	39 d3                	cmp    %edx,%ebx
801066fc:	73 66                	jae    80106764 <deallocuvm.part.0+0x84>
801066fe:	89 d6                	mov    %edx,%esi
80106700:	eb 3d                	jmp    8010673f <deallocuvm.part.0+0x5f>
80106702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106708:	8b 10                	mov    (%eax),%edx
8010670a:	f6 c2 01             	test   $0x1,%dl
8010670d:	74 26                	je     80106735 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010670f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106715:	74 58                	je     8010676f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106717:	83 ec 0c             	sub    $0xc,%esp
8010671a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106720:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106723:	52                   	push   %edx
80106724:	e8 a7 bb ff ff       	call   801022d0 <kfree>
      *pte = 0;
80106729:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010672c:	83 c4 10             	add    $0x10,%esp
8010672f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106735:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010673b:	39 f3                	cmp    %esi,%ebx
8010673d:	73 25                	jae    80106764 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010673f:	31 c9                	xor    %ecx,%ecx
80106741:	89 da                	mov    %ebx,%edx
80106743:	89 f8                	mov    %edi,%eax
80106745:	e8 86 fe ff ff       	call   801065d0 <walkpgdir>
    if(!pte)
8010674a:	85 c0                	test   %eax,%eax
8010674c:	75 ba                	jne    80106708 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010674e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106754:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010675a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106760:	39 f3                	cmp    %esi,%ebx
80106762:	72 db                	jb     8010673f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106764:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106767:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010676a:	5b                   	pop    %ebx
8010676b:	5e                   	pop    %esi
8010676c:	5f                   	pop    %edi
8010676d:	5d                   	pop    %ebp
8010676e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
8010676f:	83 ec 0c             	sub    $0xc,%esp
80106772:	68 c6 71 10 80       	push   $0x801071c6
80106777:	e8 f4 9b ff ff       	call   80100370 <panic>
8010677c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106780 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106786:	e8 c5 cf ff ff       	call   80103750 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010678b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106791:	31 c9                	xor    %ecx,%ecx
80106793:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106798:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
8010679f:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067a6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801067ab:	31 c9                	xor    %ecx,%ecx
801067ad:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067b4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067b9:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067c0:	31 c9                	xor    %ecx,%ecx
801067c2:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
801067c9:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801067d0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801067d5:	31 c9                	xor    %ecx,%ecx
801067d7:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067de:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801067e5:	ba 2f 00 00 00       	mov    $0x2f,%edx
801067ea:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
801067f1:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
801067f8:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067ff:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106806:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
8010680d:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106814:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010681b:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106822:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106829:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
80106830:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106837:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
8010683e:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
80106845:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
8010684c:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
80106853:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
8010685a:	05 f0 27 11 80       	add    $0x801127f0,%eax
8010685f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106863:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106867:	c1 e8 10             	shr    $0x10,%eax
8010686a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010686e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106871:	0f 01 10             	lgdtl  (%eax)
}
80106874:	c9                   	leave  
80106875:	c3                   	ret    
80106876:	8d 76 00             	lea    0x0(%esi),%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106880 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106880:	a1 a4 55 11 80       	mov    0x801155a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106885:	55                   	push   %ebp
80106886:	89 e5                	mov    %esp,%ebp
80106888:	05 00 00 00 80       	add    $0x80000000,%eax
8010688d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106890:	5d                   	pop    %ebp
80106891:	c3                   	ret    
80106892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068a0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
801068a6:	83 ec 1c             	sub    $0x1c,%esp
801068a9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801068ac:	85 f6                	test   %esi,%esi
801068ae:	0f 84 cd 00 00 00    	je     80106981 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801068b4:	8b 46 08             	mov    0x8(%esi),%eax
801068b7:	85 c0                	test   %eax,%eax
801068b9:	0f 84 dc 00 00 00    	je     8010699b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801068bf:	8b 7e 04             	mov    0x4(%esi),%edi
801068c2:	85 ff                	test   %edi,%edi
801068c4:	0f 84 c4 00 00 00    	je     8010698e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
801068ca:	e8 e1 d9 ff ff       	call   801042b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801068cf:	e8 fc cd ff ff       	call   801036d0 <mycpu>
801068d4:	89 c3                	mov    %eax,%ebx
801068d6:	e8 f5 cd ff ff       	call   801036d0 <mycpu>
801068db:	89 c7                	mov    %eax,%edi
801068dd:	e8 ee cd ff ff       	call   801036d0 <mycpu>
801068e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068e5:	83 c7 08             	add    $0x8,%edi
801068e8:	e8 e3 cd ff ff       	call   801036d0 <mycpu>
801068ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801068f0:	83 c0 08             	add    $0x8,%eax
801068f3:	ba 67 00 00 00       	mov    $0x67,%edx
801068f8:	c1 e8 18             	shr    $0x18,%eax
801068fb:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106902:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106909:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106910:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106917:	83 c1 08             	add    $0x8,%ecx
8010691a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106920:	c1 e9 10             	shr    $0x10,%ecx
80106923:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106929:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010692e:	e8 9d cd ff ff       	call   801036d0 <mycpu>
80106933:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010693a:	e8 91 cd ff ff       	call   801036d0 <mycpu>
8010693f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106944:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106948:	e8 83 cd ff ff       	call   801036d0 <mycpu>
8010694d:	8b 56 08             	mov    0x8(%esi),%edx
80106950:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106956:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106959:	e8 72 cd ff ff       	call   801036d0 <mycpu>
8010695e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106962:	b8 28 00 00 00       	mov    $0x28,%eax
80106967:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010696a:	8b 46 04             	mov    0x4(%esi),%eax
8010696d:	05 00 00 00 80       	add    $0x80000000,%eax
80106972:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106975:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106978:	5b                   	pop    %ebx
80106979:	5e                   	pop    %esi
8010697a:	5f                   	pop    %edi
8010697b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
8010697c:	e9 6f d9 ff ff       	jmp    801042f0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106981:	83 ec 0c             	sub    $0xc,%esp
80106984:	68 32 78 10 80       	push   $0x80107832
80106989:	e8 e2 99 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010698e:	83 ec 0c             	sub    $0xc,%esp
80106991:	68 5d 78 10 80       	push   $0x8010785d
80106996:	e8 d5 99 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
8010699b:	83 ec 0c             	sub    $0xc,%esp
8010699e:	68 48 78 10 80       	push   $0x80107848
801069a3:	e8 c8 99 ff ff       	call   80100370 <panic>
801069a8:	90                   	nop
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069b0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
801069b4:	56                   	push   %esi
801069b5:	53                   	push   %ebx
801069b6:	83 ec 1c             	sub    $0x1c,%esp
801069b9:	8b 75 10             	mov    0x10(%ebp),%esi
801069bc:	8b 45 08             	mov    0x8(%ebp),%eax
801069bf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801069c2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801069c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801069cb:	77 49                	ja     80106a16 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
801069cd:	e8 ae ba ff ff       	call   80102480 <kalloc>
  memset(mem, 0, PGSIZE);
801069d2:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
801069d5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801069d7:	68 00 10 00 00       	push   $0x1000
801069dc:	6a 00                	push   $0x0
801069de:	50                   	push   %eax
801069df:	e8 ac da ff ff       	call   80104490 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801069e4:	58                   	pop    %eax
801069e5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801069eb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801069f0:	5a                   	pop    %edx
801069f1:	6a 06                	push   $0x6
801069f3:	50                   	push   %eax
801069f4:	31 d2                	xor    %edx,%edx
801069f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069f9:	e8 52 fc ff ff       	call   80106650 <mappages>
  memmove(mem, init, sz);
801069fe:	89 75 10             	mov    %esi,0x10(%ebp)
80106a01:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106a04:	83 c4 10             	add    $0x10,%esp
80106a07:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106a0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a0d:	5b                   	pop    %ebx
80106a0e:	5e                   	pop    %esi
80106a0f:	5f                   	pop    %edi
80106a10:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106a11:	e9 2a db ff ff       	jmp    80104540 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106a16:	83 ec 0c             	sub    $0xc,%esp
80106a19:	68 71 78 10 80       	push   $0x80107871
80106a1e:	e8 4d 99 ff ff       	call   80100370 <panic>
80106a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	57                   	push   %edi
80106a34:	56                   	push   %esi
80106a35:	53                   	push   %ebx
80106a36:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106a39:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106a40:	0f 85 91 00 00 00    	jne    80106ad7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106a46:	8b 75 18             	mov    0x18(%ebp),%esi
80106a49:	31 db                	xor    %ebx,%ebx
80106a4b:	85 f6                	test   %esi,%esi
80106a4d:	75 1a                	jne    80106a69 <loaduvm+0x39>
80106a4f:	eb 6f                	jmp    80106ac0 <loaduvm+0x90>
80106a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a5e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106a64:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106a67:	76 57                	jbe    80106ac0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106a69:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a6f:	31 c9                	xor    %ecx,%ecx
80106a71:	01 da                	add    %ebx,%edx
80106a73:	e8 58 fb ff ff       	call   801065d0 <walkpgdir>
80106a78:	85 c0                	test   %eax,%eax
80106a7a:	74 4e                	je     80106aca <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106a7c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106a7e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106a81:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106a86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106a8b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106a91:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106a94:	01 d9                	add    %ebx,%ecx
80106a96:	05 00 00 00 80       	add    $0x80000000,%eax
80106a9b:	57                   	push   %edi
80106a9c:	51                   	push   %ecx
80106a9d:	50                   	push   %eax
80106a9e:	ff 75 10             	pushl  0x10(%ebp)
80106aa1:	e8 9a ae ff ff       	call   80101940 <readi>
80106aa6:	83 c4 10             	add    $0x10,%esp
80106aa9:	39 c7                	cmp    %eax,%edi
80106aab:	74 ab                	je     80106a58 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106aad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106ab5:	5b                   	pop    %ebx
80106ab6:	5e                   	pop    %esi
80106ab7:	5f                   	pop    %edi
80106ab8:	5d                   	pop    %ebp
80106ab9:	c3                   	ret    
80106aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ac0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106ac3:	31 c0                	xor    %eax,%eax
}
80106ac5:	5b                   	pop    %ebx
80106ac6:	5e                   	pop    %esi
80106ac7:	5f                   	pop    %edi
80106ac8:	5d                   	pop    %ebp
80106ac9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106aca:	83 ec 0c             	sub    $0xc,%esp
80106acd:	68 8b 78 10 80       	push   $0x8010788b
80106ad2:	e8 99 98 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106ad7:	83 ec 0c             	sub    $0xc,%esp
80106ada:	68 2c 79 10 80       	push   $0x8010792c
80106adf:	e8 8c 98 ff ff       	call   80100370 <panic>
80106ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106af0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	57                   	push   %edi
80106af4:	56                   	push   %esi
80106af5:	53                   	push   %ebx
80106af6:	83 ec 0c             	sub    $0xc,%esp
80106af9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106afc:	85 ff                	test   %edi,%edi
80106afe:	0f 88 ca 00 00 00    	js     80106bce <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106b04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106b0a:	0f 82 82 00 00 00    	jb     80106b92 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106b10:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106b16:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106b1c:	39 df                	cmp    %ebx,%edi
80106b1e:	77 43                	ja     80106b63 <allocuvm+0x73>
80106b20:	e9 bb 00 00 00       	jmp    80106be0 <allocuvm+0xf0>
80106b25:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106b28:	83 ec 04             	sub    $0x4,%esp
80106b2b:	68 00 10 00 00       	push   $0x1000
80106b30:	6a 00                	push   $0x0
80106b32:	50                   	push   %eax
80106b33:	e8 58 d9 ff ff       	call   80104490 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106b38:	58                   	pop    %eax
80106b39:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106b3f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b44:	5a                   	pop    %edx
80106b45:	6a 06                	push   $0x6
80106b47:	50                   	push   %eax
80106b48:	89 da                	mov    %ebx,%edx
80106b4a:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4d:	e8 fe fa ff ff       	call   80106650 <mappages>
80106b52:	83 c4 10             	add    $0x10,%esp
80106b55:	85 c0                	test   %eax,%eax
80106b57:	78 47                	js     80106ba0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106b59:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b5f:	39 df                	cmp    %ebx,%edi
80106b61:	76 7d                	jbe    80106be0 <allocuvm+0xf0>
    mem = kalloc();
80106b63:	e8 18 b9 ff ff       	call   80102480 <kalloc>
    if(mem == 0){
80106b68:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106b6a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106b6c:	75 ba                	jne    80106b28 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106b6e:	83 ec 0c             	sub    $0xc,%esp
80106b71:	68 a9 78 10 80       	push   $0x801078a9
80106b76:	e8 e5 9a ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106b7b:	83 c4 10             	add    $0x10,%esp
80106b7e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106b81:	76 4b                	jbe    80106bce <allocuvm+0xde>
80106b83:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106b86:	8b 45 08             	mov    0x8(%ebp),%eax
80106b89:	89 fa                	mov    %edi,%edx
80106b8b:	e8 50 fb ff ff       	call   801066e0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106b90:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b95:	5b                   	pop    %ebx
80106b96:	5e                   	pop    %esi
80106b97:	5f                   	pop    %edi
80106b98:	5d                   	pop    %ebp
80106b99:	c3                   	ret    
80106b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ba0:	83 ec 0c             	sub    $0xc,%esp
80106ba3:	68 c1 78 10 80       	push   $0x801078c1
80106ba8:	e8 b3 9a ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bad:	83 c4 10             	add    $0x10,%esp
80106bb0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106bb3:	76 0d                	jbe    80106bc2 <allocuvm+0xd2>
80106bb5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106bb8:	8b 45 08             	mov    0x8(%ebp),%eax
80106bbb:	89 fa                	mov    %edi,%edx
80106bbd:	e8 1e fb ff ff       	call   801066e0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106bc2:	83 ec 0c             	sub    $0xc,%esp
80106bc5:	56                   	push   %esi
80106bc6:	e8 05 b7 ff ff       	call   801022d0 <kfree>
      return 0;
80106bcb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106bce:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106bd1:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106bd3:	5b                   	pop    %ebx
80106bd4:	5e                   	pop    %esi
80106bd5:	5f                   	pop    %edi
80106bd6:	5d                   	pop    %ebp
80106bd7:	c3                   	ret    
80106bd8:	90                   	nop
80106bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106be3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106be5:	5b                   	pop    %ebx
80106be6:	5e                   	pop    %esi
80106be7:	5f                   	pop    %edi
80106be8:	5d                   	pop    %ebp
80106be9:	c3                   	ret    
80106bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106bf0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bf6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bfc:	39 d1                	cmp    %edx,%ecx
80106bfe:	73 10                	jae    80106c10 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106c00:	5d                   	pop    %ebp
80106c01:	e9 da fa ff ff       	jmp    801066e0 <deallocuvm.part.0>
80106c06:	8d 76 00             	lea    0x0(%esi),%esi
80106c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c10:	89 d0                	mov    %edx,%eax
80106c12:	5d                   	pop    %ebp
80106c13:	c3                   	ret    
80106c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c20 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	83 ec 0c             	sub    $0xc,%esp
80106c29:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106c2c:	85 f6                	test   %esi,%esi
80106c2e:	74 59                	je     80106c89 <freevm+0x69>
80106c30:	31 c9                	xor    %ecx,%ecx
80106c32:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c37:	89 f0                	mov    %esi,%eax
80106c39:	e8 a2 fa ff ff       	call   801066e0 <deallocuvm.part.0>
80106c3e:	89 f3                	mov    %esi,%ebx
80106c40:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106c46:	eb 0f                	jmp    80106c57 <freevm+0x37>
80106c48:	90                   	nop
80106c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c50:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106c53:	39 fb                	cmp    %edi,%ebx
80106c55:	74 23                	je     80106c7a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106c57:	8b 03                	mov    (%ebx),%eax
80106c59:	a8 01                	test   $0x1,%al
80106c5b:	74 f3                	je     80106c50 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106c5d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c62:	83 ec 0c             	sub    $0xc,%esp
80106c65:	83 c3 04             	add    $0x4,%ebx
80106c68:	05 00 00 00 80       	add    $0x80000000,%eax
80106c6d:	50                   	push   %eax
80106c6e:	e8 5d b6 ff ff       	call   801022d0 <kfree>
80106c73:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106c76:	39 fb                	cmp    %edi,%ebx
80106c78:	75 dd                	jne    80106c57 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106c7a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c80:	5b                   	pop    %ebx
80106c81:	5e                   	pop    %esi
80106c82:	5f                   	pop    %edi
80106c83:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106c84:	e9 47 b6 ff ff       	jmp    801022d0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106c89:	83 ec 0c             	sub    $0xc,%esp
80106c8c:	68 dd 78 10 80       	push   $0x801078dd
80106c91:	e8 da 96 ff ff       	call   80100370 <panic>
80106c96:	8d 76 00             	lea    0x0(%esi),%esi
80106c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ca0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	56                   	push   %esi
80106ca4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106ca5:	e8 d6 b7 ff ff       	call   80102480 <kalloc>
80106caa:	85 c0                	test   %eax,%eax
80106cac:	74 6a                	je     80106d18 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106cae:	83 ec 04             	sub    $0x4,%esp
80106cb1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106cb3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106cb8:	68 00 10 00 00       	push   $0x1000
80106cbd:	6a 00                	push   $0x0
80106cbf:	50                   	push   %eax
80106cc0:	e8 cb d7 ff ff       	call   80104490 <memset>
80106cc5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106cc8:	8b 43 04             	mov    0x4(%ebx),%eax
80106ccb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106cce:	83 ec 08             	sub    $0x8,%esp
80106cd1:	8b 13                	mov    (%ebx),%edx
80106cd3:	ff 73 0c             	pushl  0xc(%ebx)
80106cd6:	50                   	push   %eax
80106cd7:	29 c1                	sub    %eax,%ecx
80106cd9:	89 f0                	mov    %esi,%eax
80106cdb:	e8 70 f9 ff ff       	call   80106650 <mappages>
80106ce0:	83 c4 10             	add    $0x10,%esp
80106ce3:	85 c0                	test   %eax,%eax
80106ce5:	78 19                	js     80106d00 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ce7:	83 c3 10             	add    $0x10,%ebx
80106cea:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106cf0:	75 d6                	jne    80106cc8 <setupkvm+0x28>
80106cf2:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106cf4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106cf7:	5b                   	pop    %ebx
80106cf8:	5e                   	pop    %esi
80106cf9:	5d                   	pop    %ebp
80106cfa:	c3                   	ret    
80106cfb:	90                   	nop
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106d00:	83 ec 0c             	sub    $0xc,%esp
80106d03:	56                   	push   %esi
80106d04:	e8 17 ff ff ff       	call   80106c20 <freevm>
      return 0;
80106d09:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106d0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106d0f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106d11:	5b                   	pop    %ebx
80106d12:	5e                   	pop    %esi
80106d13:	5d                   	pop    %ebp
80106d14:	c3                   	ret    
80106d15:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106d18:	31 c0                	xor    %eax,%eax
80106d1a:	eb d8                	jmp    80106cf4 <setupkvm+0x54>
80106d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d20 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106d26:	e8 75 ff ff ff       	call   80106ca0 <setupkvm>
80106d2b:	a3 a4 55 11 80       	mov    %eax,0x801155a4
80106d30:	05 00 00 00 80       	add    $0x80000000,%eax
80106d35:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106d38:	c9                   	leave  
80106d39:	c3                   	ret    
80106d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d40 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d40:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d41:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d43:	89 e5                	mov    %esp,%ebp
80106d45:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d48:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d4b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d4e:	e8 7d f8 ff ff       	call   801065d0 <walkpgdir>
  if(pte == 0)
80106d53:	85 c0                	test   %eax,%eax
80106d55:	74 05                	je     80106d5c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106d57:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106d5a:	c9                   	leave  
80106d5b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106d5c:	83 ec 0c             	sub    $0xc,%esp
80106d5f:	68 ee 78 10 80       	push   $0x801078ee
80106d64:	e8 07 96 ff ff       	call   80100370 <panic>
80106d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d70 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106d79:	e8 22 ff ff ff       	call   80106ca0 <setupkvm>
80106d7e:	85 c0                	test   %eax,%eax
80106d80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d83:	0f 84 c5 00 00 00    	je     80106e4e <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d89:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d8c:	85 c9                	test   %ecx,%ecx
80106d8e:	0f 84 9c 00 00 00    	je     80106e30 <copyuvm+0xc0>
80106d94:	31 ff                	xor    %edi,%edi
80106d96:	eb 4a                	jmp    80106de2 <copyuvm+0x72>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106da0:	83 ec 04             	sub    $0x4,%esp
80106da3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106da9:	68 00 10 00 00       	push   $0x1000
80106dae:	53                   	push   %ebx
80106daf:	50                   	push   %eax
80106db0:	e8 8b d7 ff ff       	call   80104540 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106db5:	58                   	pop    %eax
80106db6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106dbc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dc1:	5a                   	pop    %edx
80106dc2:	ff 75 e4             	pushl  -0x1c(%ebp)
80106dc5:	50                   	push   %eax
80106dc6:	89 fa                	mov    %edi,%edx
80106dc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106dcb:	e8 80 f8 ff ff       	call   80106650 <mappages>
80106dd0:	83 c4 10             	add    $0x10,%esp
80106dd3:	85 c0                	test   %eax,%eax
80106dd5:	78 69                	js     80106e40 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106dd7:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106ddd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106de0:	76 4e                	jbe    80106e30 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106de2:	8b 45 08             	mov    0x8(%ebp),%eax
80106de5:	31 c9                	xor    %ecx,%ecx
80106de7:	89 fa                	mov    %edi,%edx
80106de9:	e8 e2 f7 ff ff       	call   801065d0 <walkpgdir>
80106dee:	85 c0                	test   %eax,%eax
80106df0:	74 6d                	je     80106e5f <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106df2:	8b 00                	mov    (%eax),%eax
80106df4:	a8 01                	test   $0x1,%al
80106df6:	74 5a                	je     80106e52 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106df8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106dfa:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106dff:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106e05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106e08:	e8 73 b6 ff ff       	call   80102480 <kalloc>
80106e0d:	85 c0                	test   %eax,%eax
80106e0f:	89 c6                	mov    %eax,%esi
80106e11:	75 8d                	jne    80106da0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106e13:	83 ec 0c             	sub    $0xc,%esp
80106e16:	ff 75 e0             	pushl  -0x20(%ebp)
80106e19:	e8 02 fe ff ff       	call   80106c20 <freevm>
  return 0;
80106e1e:	83 c4 10             	add    $0x10,%esp
80106e21:	31 c0                	xor    %eax,%eax
}
80106e23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e26:	5b                   	pop    %ebx
80106e27:	5e                   	pop    %esi
80106e28:	5f                   	pop    %edi
80106e29:	5d                   	pop    %ebp
80106e2a:	c3                   	ret    
80106e2b:	90                   	nop
80106e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106e30:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e36:	5b                   	pop    %ebx
80106e37:	5e                   	pop    %esi
80106e38:	5f                   	pop    %edi
80106e39:	5d                   	pop    %ebp
80106e3a:	c3                   	ret    
80106e3b:	90                   	nop
80106e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	56                   	push   %esi
80106e44:	e8 87 b4 ff ff       	call   801022d0 <kfree>
      goto bad;
80106e49:	83 c4 10             	add    $0x10,%esp
80106e4c:	eb c5                	jmp    80106e13 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106e4e:	31 c0                	xor    %eax,%eax
80106e50:	eb d1                	jmp    80106e23 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106e52:	83 ec 0c             	sub    $0xc,%esp
80106e55:	68 12 79 10 80       	push   $0x80107912
80106e5a:	e8 11 95 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106e5f:	83 ec 0c             	sub    $0xc,%esp
80106e62:	68 f8 78 10 80       	push   $0x801078f8
80106e67:	e8 04 95 ff ff       	call   80100370 <panic>
80106e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e70 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e71:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e73:	89 e5                	mov    %esp,%ebp
80106e75:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7e:	e8 4d f7 ff ff       	call   801065d0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106e83:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80106e85:	89 c2                	mov    %eax,%edx
80106e87:	83 e2 05             	and    $0x5,%edx
80106e8a:	83 fa 05             	cmp    $0x5,%edx
80106e8d:	75 11                	jne    80106ea0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e8f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80106e94:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e95:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106e9a:	c3                   	ret    
80106e9b:	90                   	nop
80106e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106ea0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106ea2:	c9                   	leave  
80106ea3:	c3                   	ret    
80106ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106eb0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	57                   	push   %edi
80106eb4:	56                   	push   %esi
80106eb5:	53                   	push   %ebx
80106eb6:	83 ec 1c             	sub    $0x1c,%esp
80106eb9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106ebc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ebf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ec2:	85 db                	test   %ebx,%ebx
80106ec4:	75 40                	jne    80106f06 <copyout+0x56>
80106ec6:	eb 70                	jmp    80106f38 <copyout+0x88>
80106ec8:	90                   	nop
80106ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ed0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ed3:	89 f1                	mov    %esi,%ecx
80106ed5:	29 d1                	sub    %edx,%ecx
80106ed7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106edd:	39 d9                	cmp    %ebx,%ecx
80106edf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106ee2:	29 f2                	sub    %esi,%edx
80106ee4:	83 ec 04             	sub    $0x4,%esp
80106ee7:	01 d0                	add    %edx,%eax
80106ee9:	51                   	push   %ecx
80106eea:	57                   	push   %edi
80106eeb:	50                   	push   %eax
80106eec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106eef:	e8 4c d6 ff ff       	call   80104540 <memmove>
    len -= n;
    buf += n;
80106ef4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ef7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80106efa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106f00:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106f02:	29 cb                	sub    %ecx,%ebx
80106f04:	74 32                	je     80106f38 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106f06:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f08:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106f0b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f0e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f14:	56                   	push   %esi
80106f15:	ff 75 08             	pushl  0x8(%ebp)
80106f18:	e8 53 ff ff ff       	call   80106e70 <uva2ka>
    if(pa0 == 0)
80106f1d:	83 c4 10             	add    $0x10,%esp
80106f20:	85 c0                	test   %eax,%eax
80106f22:	75 ac                	jne    80106ed0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106f24:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106f27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106f2c:	5b                   	pop    %ebx
80106f2d:	5e                   	pop    %esi
80106f2e:	5f                   	pop    %edi
80106f2f:	5d                   	pop    %ebp
80106f30:	c3                   	ret    
80106f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106f3b:	31 c0                	xor    %eax,%eax
}
80106f3d:	5b                   	pop    %ebx
80106f3e:	5e                   	pop    %esi
80106f3f:	5f                   	pop    %edi
80106f40:	5d                   	pop    %ebp
80106f41:	c3                   	ret    