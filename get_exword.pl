#!/usr/bin/perl
use Encode;
use utf8;

$inputfile="value.txt";
$fnum=1;

#�e�t�@�C�����疼���A�ŗL�����A�����A�`�e���𒊏o���Ċi�[
for($i=0; $i<$fnum; $i++){
	$j=0;
	open(IN,$inputfile) || die "$!";
	#binmode(IN,":encoding(euc-jp)");
	
	while(<IN>){
		chomp;
		@list = split(/\t/);
		
		if($list[1] =~ /NN|VV|JJ/){
			$words[$i][$j] = $list[2];
			$j++;
		}
	}
	close(IN);
}

#�N���X���Ƃ̃��[�h���X�g���A���[�h���ƂɃN���X�]�������悤�ɕό`
for($i=0; $i<$fnum; $i++){
	for($j=0; $j<=$#{$words[$i]}; $j++){
		$flag=0;
		foreach(@corpus){
			if(@{$_}[0] eq $words[$i][$j]){
				$flag=1;
				@{$_}[($i+1)]++;
				break;
			}
		}
		if($flag==0){
			$str=$words[$i][$j];
			push(@corpus, [$str,0,0,0,0,0,0,0,0,0,0]);
			$corpus[$#corpus][($i+1)]++;
		}
	}
}

foreach (@corpus){
	$str = @{$_}[0];
	$sum=0;
	for($i=0; $i<10; $i++) {$sum+=@{$_}[$i+1];}
	$hash{$str} = $sum;
}
for my $key (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
        print $key . ",";
}
print "\n\n\n";
for my $key (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
        print $key . " : " . $hash{$key} . "\n";
}

#end